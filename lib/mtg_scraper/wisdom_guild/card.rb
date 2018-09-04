# frozen_string_literal: true

require 'nokogiri'
require 'mtg_scraper/cache'
require 'mtg_scraper/wisdom_guild/detail'
require 'mtg_scraper/wisdom_guild/parse_html'
require 'mtg_scraper/utils/html_util'

module MtgScraper

  module WisdomGuild

    class Card

      def initialize(html)
        @html = html
      end

      def name
        return nil if error?
        @name
      end

      def english_name
        return nil if error?
        @english_name
      end

      def multiverseid
        return nil if error?
        @multiverseid
      end

      def details
        return nil if error?
        @details
      end

      def error?
        return @error unless @error.nil?
        parse_html
        @error
      end

      def to_hash
        {
          name: name,
          english_name: english_name,
          multiverseid: multiverseid,
          details: details.map{ |detail| detail.to_hash },
        }
      end

      private

        def parse_html
          result = ParseHtml.parse(@html)
          @error = result[:error]
          return if @error
          @name = result[:name]
          @english_name = result[:english_name]
          @multiverseid = result[:multiverseid]
          @details = result[:details].map{ |detail| Detail.new(detail) }
        end

    end

  end

end
