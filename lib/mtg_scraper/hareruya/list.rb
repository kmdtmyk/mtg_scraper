# frozen_string_literal: true

require 'nokogiri'

module MtgScraper::Hareruya

  class List

    def initialize(html)
      @html = html
    end

    def size
      doc.css('.itemListLine a').size
    end

    def [](nth)
      node = doc.css('.itemListLine a')[nth]
      parse_item_name(node.css('.itemName').text)
    end

    private

      def doc
        Nokogiri::HTML.parse(@html)
      end

      def parse_item_name(text)
        %r{《([^/]+)/([^/]+)》}.match(text)
        name = Regexp.last_match(1)
        english_name = Regexp.last_match(2)
        {
          name: name,
          english_name: english_name,
        }
      end

  end

end
