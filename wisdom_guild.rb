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
  end

  def self.parse_levelup(html)
  end

  def self.parse_flip(html)
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
      %r{(伝説の)?(\S+)( — (\S+))?}.match(text)
      legendary_text = Regexp.last_match(1)
      type_text = Regexp.last_match(2)
      subtype_text = Regexp.last_match(4)

      legendary = legendary_text.nil? == false
      types = []
      subtypes = []

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

      {
        legendary: legendary,
        types: types,
        subtypes: subtypes,
      }
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

    def self.name_to_url(name)
      return 'http://whisper.wisdom-guild.net/card/' + URI.escape(name)
    end

end
