require 'uri'
require 'nokogiri'
# frozen_string_literal: true

require 'mtg_scraper/cache'
require 'mtg_scraper/utils/html_util'

module MtgScraper

  module Hareruya

    class List

      @@interval = 5
      @@last_time = nil

      def initialize(name)
        @url = "http://www.hareruyamtg.com/jp/c/#{URI.escape(name)}/"
      end

      def html
        return @html unless @html.nil?
        return read_cache if cached?
        fetch_html
      end

      def cached?
        MtgScraper::Cache.exist?(@url)
      end

      def to_hash
        doc = Nokogiri::HTML.parse(html)
        doc.css('.itemListLine a').each do |item|
          # p item.css('.itemName').inner_text
        end
        []
      end

      private

        def parse_html
          result = ParseHtml.parse(html)
          @error = result[:error]
          return if @error
          @name = result[:name]
          @english_name = result[:english_name]
          @multiverseid = result[:multiverseid]
          @details = result[:details].map{ |detail| Detail.new(detail) }
        end

        def read_cache
          @html = MtgScraper::Cache.read(@url)
        end

        def write_cache
          MtgScraper::Cache.write(@url, @html)
        end

        def fetch_html
          unless @@last_time.nil?
            sleep_time = @@interval - (Time.now - @@last_time)
            sleep sleep_time if 0 < sleep_time
          end
          @html = MtgScraper::Utils::HtmlUtil.get(@url)
          @@last_time = Time.now
          write_cache
          @html
        end

    end

  end

end