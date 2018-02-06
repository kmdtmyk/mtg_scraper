require 'nokogiri'
require 'wisdom_guild/detail'
require 'wisdom_guild/parse'
require 'wisdom_guild/file_util'
require 'wisdom_guild/html_util'

module WisdomGuild

  class Card

    attr_reader :name
    attr_reader :english_name
    attr_reader :multiverseid
    attr_reader :details

    def initialize(name)
      card = Card::get(name)
      @name = card[:name]
      @english_name = card[:english_name]
      @multiverseid = card[:multiverseid]
      @details = []
      card[:details].each{ |detail| @details << Detail.new(detail) }
    end

    def to_hash
      {
        name: @name,
        english_name: @english_name,
        multiverseid: @multiverseid,
        details: @details.map{ |detail| detail.to_hash },
      }
    end

    def self.cached?(name)
      File.exist?(name_to_file_path(name))
    end

    def self.get(name)
      html = get_html_and_cache(name)

      doc = Nokogiri::HTML.parse(html)
      title_text = doc.css('.wg-title').inner_text
      %r{([^/\n\t]+)\/([^/\n\t]+)[\n\t]*}.match(title_text)

      name = Regexp.last_match(1)
      english_name = Regexp.last_match(2)
      gatherer = doc.css('[target="_GATHERER"]')
      multiverseid = gatherer[0][:href].split('multiverseid=')[-1].to_i

      details = parse_details(html)
      {
        name: name,
        english_name: english_name,
        multiverseid: multiverseid,
        details: details
      }
    end

    def self.get_html_and_cache(name)
      file_path = name_to_file_path(name)
      html = FileUtil.read(file_path)
      return html unless html.nil?

      url = name_to_url(name)
      html = HtmlUtil.get(url)
      FileUtil.write(file_path, html)
      html
    end

    def self.parse_details(html)
      layout = get_layout(html)
      return parse_normal(html) if layout == 'normal'
      return parse_double_faced(html) if layout == 'double_faced'
      return parse_split(html) if layout == 'split'
      return parse_levelup(html) if layout == 'levelup'
      return parse_flip(html) if layout == 'flip'
    end

    def self.parse_normal(html)
      table = get_table(html)
      text_array = table_to_array(table)
      [parse_text_array(text_array)]
    end

    def self.parse_double_faced(html)
      parse_double_faced_or_flip(html)
    end

    def self.parse_split(html)
      table = get_table(html)
      text_array = table_to_array(table)
      (text_array[0].length - 1).times
        .map{|i|
          text_array[0..6].map{ |row| [row[0], row[i + 1]] }
        }
        .map{ |array| parse_text_array(array) }
    end

    def self.parse_levelup(html)
      table = get_table(html)
      text_array = table_to_array(table)

      #一部のtr開始タグが抜けている対応
      if text_array.length < 17
        table.css('td').each_with_index do |td, index|
          text_array.insert(7, ['テキスト', td.inner_text]) if index == 6
          text_array.insert(11, ['テキスト', td.inner_text]) if index == 9
        end
      end

      detail = parse_text_array [
        text_array[0],
        text_array[1],
        text_array[2],
        text_array[5],
        text_array[14],
        text_array[15],
      ]

      level1 = parse_level_text(text_array[6][0])
      level2 = parse_level_text(text_array[10][0])

      detail[:text] = [
        text_array[3][1],
        'Lv ' + level1,
        text_array[9][1],
        text_array[7][1],
        'Lv ' + level2,
        text_array[13][1],
        text_array[11][1],
      ].join("\n")

      detail[:oracle] = [
        text_array[4][1],
        'LEVEL ' + level1,
        text_array[9][1],
        text_array[8][1],
        'LEVEL ' + level2,
        text_array[13][1],
        text_array[12][1],
      ].join("\n")

      [detail]
    end

    def self.parse_level_text(text)
      %r{Lv(\S*)}.match(text)
      Regexp.last_match(1)
    end

    def self.parse_flip(html)
      parse_double_faced_or_flip(html)
    end

    def self.get_layout(html)
      table = get_table(html)
      return 'double_faced' if table.css('th.ddc').length > 0
      return 'split' if table.css('tr:nth-child(1) td').length > 1
      return 'levelup' if table.css('tr:nth-child(7) td').length == 0
      return 'flip' if table.css('tr').length > 15
      return 'normal'
    end

    def self.get_table(html)
      doc = Nokogiri::HTML.parse(html)
      doc.css('.wg-whisper-card-detail table')
    end

    def self.table_to_array(table)
      table.css('tr').map do |tr|
        tr.css('th, td').map{ |td| td.inner_text }
      end
    end

    def self.parse_double_faced_or_flip(html)
      table = get_table(html)
      text_array = table_to_array(table)
      second_name_index = text_array[1..-1].index{ |name, value| name == 'カード名' } + 1
      [
        parse_text_array(text_array[0..second_name_index - 1]),
        parse_text_array(text_array[second_name_index..-2]),
      ]
    end

    def self.parse_text_array(array)
      result = {}
      array.each do |name, value|
        if name == 'カード名'
          result.merge!(Parse.name(value))
        elsif name == 'マナコスト'
          result.merge!(Parse.mana_cost(value))
        elsif name == 'タイプ'
          result.merge!(Parse.type(value))
        elsif name == 'テキスト'
          result.merge!(Parse.text(value))
        elsif name == 'オラクル'
          result.merge!(Parse.oracle(value))
        elsif name == 'Ｐ／Ｔ'
          result.merge!(Parse.size(value))
        elsif name == '忠誠度'
          result.merge!(Parse.loyalty(value))
        elsif name == 'フレーバ'
          result.merge!(Parse.flavor_text(value))
        elsif name == 'デザイン'
        elsif name == 'イラスト'
          result.merge!(Parse.artist(value))
        elsif name == 'セット等'
        elsif name == '再録'
        elsif name == '絵違い'
        end
      end
      result
    end

    def self.name_to_url(name)
      return 'http://whisper.wisdom-guild.net/card/' + URI.escape(name)
    end

    def self.name_to_file_path(name)
      FileUtil.cache_dir + "/#{name}.html"
    end

  end

end
