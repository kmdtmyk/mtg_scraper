# frozen_string_literal: true

require 'nokogiri'

module MtgScraper

  module Hareruya

    class List

      def initialize(html)
        @html = html
      end

      def size
        doc = Nokogiri::HTML.parse(@html)
        doc.css('.itemListLine a').size
      end

    end

  end

end
