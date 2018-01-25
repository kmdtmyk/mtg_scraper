require 'nokogiri'
require_relative 'html_man'
require_relative 'file_man'

class WisdomGuild

  def self.get_html_and_cache(name)
    file_path = File.dirname(__FILE__) + "/cache/#{name}.html"
    html = FileMan.read(file_path)
    return html unless html.nil?

    url = name_to_url(name)
    html = HtmlMan.get(url)
    FileMan.write(file_path, html)
    return html
  end

  def self.normal(html)
    details = []
    doc = Nokogiri::HTML.parse(html)
    doc.css('.wg-whisper-card-detail table').each do |table|
      detail = {}

      name_text = table.css('tr:nth-child(1) td:nth-child(2)').inner_text
      detail.merge!(parse_name_text(name_text))
      type_text = table.css('tr:nth-child(3) td:nth-child(2)').inner_text
      detail.merge!(parse_type_text(type_text))
      size_text = table.css('tr:nth-child(6) td:nth-child(2)').inner_text
      detail.merge!(parse_size_text(size_text))

      mana_cost = table.css('tr:nth-child(2) td:nth-child(2)').inner_text
      text = table.css('tr:nth-child(4) td:nth-child(2)').inner_text
      oracle = table.css('tr:nth-child(5) td:nth-child(2)').inner_text
      flavor_text = table.css('tr:nth-child(7) td:nth-child(2)').inner_text

      detail.merge!({
        mana_cost: mana_cost,
        text: text,
        oracle: oracle,
        flavor_text: flavor_text,
      })
      details.push(detail)
    end
    details
  end

  def self.aftermath(html)
  end

  def self.double_faced(html)
  end

  def self.meld(html)
  end

  def self.get_layout(html)
    table = get_table(html)
    return 'double_faced' if table.css('th.ddc').length > 0
    return 'split' if table.css('tr:nth-child(1) td').length > 1
    return 'levelup' if table.css('tr:nth-child(7) td').length == 0
    return 'flip'if table.css('tr').length > 15
    return 'normal'
  end

  def self.name_to_url(name)
    return 'http://whisper.wisdom-guild.net/card/' + URI.escape(name)
  end

  private

    def self.get_table(html)
      doc = Nokogiri::HTML.parse(html)
      doc.css('.wg-whisper-card-detail table')
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
      types = type_text.split('・').map{|type| {name: type}}
      subtypes = subtype_text.split('・').map{|subtype|
        %r{(\S+)\((\S+)\)}.match(subtype)
        {
          name: Regexp.last_match(1),
          english_name: Regexp.last_match(2),
        }
      }

      {
        legendary: legendary,
        types: types,
        subtypes: subtypes,
      }
    end

    def self.parse_size_text(text)
      %r{(\d+)/(\d+)}.match(text)
      power = Regexp.last_match(1).to_i
      toughness = Regexp.last_match(2).to_i
      {
        size: text,
        power: power,
        toughness: toughness,
      }
    end

end
