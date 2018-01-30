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

    detail = {}
    detail.merge!(parse_name_text(text_array[0][1]))
    detail.merge!(parse_type_text(text_array[2][1]))

    if text_array[5][0] == 'Ｐ／Ｔ'
      detail.merge!(parse_size_text(text_array[5][1]))
      flavor_text = text_array[6][1]
    elsif text_array[5][0] == '忠誠度'
      detail.merge!(parse_loyalty_text(text_array[5][1]))
      flavor_text = text_array[6][1]
    else
      flavor_text = text_array[5][1]
    end

    mana_cost = text_array[1][1]
    text = text_array[3][1]
    oracle = text_array[4][1]

    detail.merge!({
      mana_cost: mana_cost,
      text: text,
      oracle: oracle,
      flavor_text: flavor_text,
    })

    [detail]
  end

  def self.parse_double_faced(html)
  end

  def self.parse_split(html)
    table = get_table(html)
    text_array = table_to_array(table)

    (text_array[0].length - 1).times.map do |i|
      col = i + 1
      detail = {}
      detail.merge!(parse_name_text(text_array[0][col]))
      detail.merge!(parse_type_text(text_array[2][col]))

      if text_array[5][0] == 'Ｐ／Ｔ'
        detail.merge!(parse_size_text(text_array[5][col]))
        flavor_text = text_array[6][col]
      elsif text_array[5][0] == '忠誠度'
        detail.merge!(parse_loyalty_text(text_array[5][col]))
        flavor_text = text_array[6][col]
      else
        flavor_text = text_array[5][col]
      end

      mana_cost = text_array[1][col]
      text = text_array[3][col]
      oracle = text_array[4][col]

      detail.merge!({
        mana_cost: mana_cost,
        text: text,
        oracle: oracle,
        flavor_text: flavor_text,
      })
      detail
    end
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

    detail = {}
    detail.merge!(parse_name_text(text_array[0][1]))
    detail.merge!(parse_type_text(text_array[2][1]))
    detail.merge!(parse_size_text(text_array[5][1]))

    level1 = parse_level_text(text_array[6][0])
    level2 = parse_level_text(text_array[10][0])

    mana_cost = text_array[1][1]
    text = [
      text_array[3][1],
      'Lv ' + level1,
      text_array[9][1],
      text_array[7][1],
      'Lv ' + level2,
      text_array[13][1],
      text_array[11][1],
    ].join("\n")
    oracle = [
      text_array[4][1],
      'LEVEL ' + level1,
      text_array[9][1],
      text_array[8][1],
      'LEVEL ' + level2,
      text_array[13][1],
      text_array[12][1],
    ].join("\n")
    flavor_text = text_array[14][1]

    detail.merge!({
      mana_cost: mana_cost,
      text: text,
      oracle: oracle,
      flavor_text: flavor_text,
    })


    [detail]
  end

  def self.parse_flip(html)
    table = get_table(html)
    text_array = table_to_array(table)
    2.times.map do |i|
      offset = i * 8
      detail = {}
      detail.merge!(parse_name_text(text_array[0 + offset][1]))
      detail.merge!(parse_type_text(text_array[2 + offset][1]))
      if i == 1 and text_array.length == 16
        flavor_text = text_array[5 + offset][1]
      else
        detail.merge!(parse_size_text(text_array[5 + offset][1]))
        flavor_text = text_array[6 + offset][1]
      end
      mana_cost = text_array[1][1]
      text = text_array[3 + offset][1]
      oracle = text_array[4 + offset][1]
      detail.merge!({
        mana_cost: mana_cost,
        text: text,
        oracle: oracle,
        flavor_text: flavor_text,
      })
    end
  end

  def self.get_layout(html)
    table = get_table(html)
    return 'double_faced' if table.css('th.ddc').length > 0
    return 'split' if table.css('tr:nth-child(1) td').length > 1
    return 'levelup' if table.css('tr:nth-child(7) td').length == 0
    return 'flip'if table.css('tr').length > 15
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
