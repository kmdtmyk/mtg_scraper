# frozen_string_literal: true

require 'mtg_scraper/hareruya/list/v1'
require 'mtg_scraper/hareruya/list/v1_item'
require 'mtg_scraper/hareruya/list/v2'
require 'mtg_scraper/hareruya/list/v2_category'
require 'mtg_scraper/hareruya/list/v2_item'

module MtgScraper
  module Hareruya
    module_function

    def parse(html)
      return if html.nil?
      if html.start_with? '<!doctype html>'
        List::V2.new(html)
      else
        List::V1.new(html)
      end
    end

  end
end
