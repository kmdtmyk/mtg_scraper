require 'uri'
require 'nokogiri'
require_relative 'html_man'
require_relative 'file_man'

class WisdomGuild

  def self.get_html_and_cache(name)
    file_path = File.dirname(__FILE__) + "/cache/#{name}.html"
    html = FileMan.read(file_path)

    unless html.nil? or html.empty?
      return html
    end

    url = name_to_url(name)
    html = HtmlMan.get(url)
    FileMan.write(file_path, html)
    return html
  end

  def self.scraping(html)
  end

  def self.name_to_url(name)
    return 'http://whisper.wisdom-guild.net/card/' + URI.escape(name)
  end

end
