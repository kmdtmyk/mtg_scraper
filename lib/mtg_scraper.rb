# frozen_string_literal: true

require 'card_name'
require 'card_set'
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
    if url.match %r(www.hareruyamtg.com/jp/c)
      Hareruya::List::V1
    elsif url.match %r(www.hareruyamtg.com/ja/products)
      Hareruya::List::V2
    elsif url.match %r(whisper.wisdom-guild.net)
      WisdomGuild::Card
    elsif url.match %r(mtgjson.com)
      Mtgjson::Set
    end
  end

end
