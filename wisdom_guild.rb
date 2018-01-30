require 'nokogiri'
require_relative 'html_man'
require_relative 'file_man'

class WisdomGuild

  def self.get(name)
    html = WisdomGuild.get_html_and_cache(name)
    WisdomGuild.parse(html)
  end

  def self.get_html_and_cache(name)
    file_path = File.dirname(__FILE__) + "/cache/#{name}.html"
    html = FileMan.read(file_path)
    return html unless html.nil?

    url = name_to_url(name)
    html = HtmlMan.get(url)
    FileMan.write(file_path, html)
    html
  end

  def self.parse(html)
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

  private

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

    def self.parse_name_text(text)
      %r{([^/\n\t]+)\/([^/\n\t]+)[\n\t]*（(.+)）}.match(text)
      name = Regexp.last_match(1)
      english_name = Regexp.last_match(2)
      furigana = Regexp.last_match(3)
      {
        name: name,
        english_name: english_name,
        furigana: furigana,
      }
    end

    def self.parse_text_array(array)
      result = {}
      array.each do |name, value|
        if name == 'カード名'
          result.merge!(parse_name_text(value))
        elsif name == 'マナコスト'
          result[:mana_cost] = value
        elsif name == 'タイプ'
          result.merge!(parse_type_text(value))
        elsif name == 'テキスト'
          result[:text] = value
        elsif name == 'オラクル'
          result[:oracle] = value
        elsif name == 'Ｐ／Ｔ'
          result.merge!(parse_size_text(value))
        elsif name == '忠誠度'
          result.merge!(parse_loyalty_text(value))
        elsif name == 'フレーバ'
          result[:flavor_text] = value
        end
      end
      result
    end

    def self.parse_type_text(text)
      %r{(〔(.*)〕 )?(伝説の|基本|氷雪|持続|精鋭|宿主|ワールド・)*(\S+)( — (\S+))?}.match(text)
      color = Regexp.last_match(2)
      supertype_text = Regexp.last_match(3)
      type_text = Regexp.last_match(4)
      subtype_text = Regexp.last_match(6)

      supertypes = []
      types = []
      subtypes = []

      supertypes << { name: '伝説の' } if %r{伝説の}.match(text)
      supertypes << { name: '基本' } if %r{基本}.match(text)
      supertypes << { name: '氷雪' } if %r{氷雪}.match(text)
      supertypes << { name: 'ワールド' } if %r{ワールド}.match(text)

      unless type_text.nil?
        type_text.split('・').each do |type|
          types << {name: type}
        end
      end

      unless subtype_text.nil?
        subtype_text.split('・').each do |subtype|
          %r{(\S+)\((\S+)\)}.match(subtype)
          subtypes << {
            name: Regexp.last_match(1),
            english_name: Regexp.last_match(2),
          }
        end
      end

      result = {
        supertypes: supertypes,
        types: types,
        subtypes: subtypes,
      }

      unless color.nil?
        result[:color] = color
      end

      result
    end

    def self.parse_size_text(text)
      %r{(.*)/(.*)}.match(text)
      power = Regexp.last_match(1).to_i
      toughness = Regexp.last_match(2).to_i
      {
        size: text,
        power: power,
        toughness: toughness,
      }
    end

    def self.parse_loyalty_text(text)
      {
        size: text,
        loyalty: text.to_i,
      }
    end

    def self.parse_level_text(text)
      %r{Lv(\S*)}.match(text)
      Regexp.last_match(1)
    end

    def self.name_to_url(name)
      return 'http://whisper.wisdom-guild.net/card/' + URI.escape(name)
    end

end
