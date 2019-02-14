# frozen_string_literal: true

require 'mtg_scraper/version'
require 'mtg_scraper/page'
require 'mtg_scraper/cache'
require 'mtg_scraper/wisdom_guild'
require 'mtg_scraper/hareruya'
require 'mtg_scraper/mtgjson/set'

module MtgScraper
  module_function

  def url(url)
    parser = self.parser(url)
    return if parser.nil?
    page = Page.new(url)
    parser.new(page.html)
  end

  def parser(url)
    host = URI.parse(url).host
    if host == 'whisper.wisdom-guild.net'
      WisdomGuild::Card
    elsif host == 'www.hareruyamtg.com'
      Hareruya::List
    elsif host == 'mtgjson.com'
      Mtgjson::Set
    end
  end

end
