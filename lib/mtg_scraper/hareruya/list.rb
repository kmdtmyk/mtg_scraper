# frozen_string_literal: true

require 'nokogiri'

module MtgScraper::Hareruya
  class List
    include Enumerable

    def initialize(html)
      @html = html
    end

    def each
      nodes.each do |node|
        yield parse_node(node)
      end
    end

    def size
      nodes.size
    end

    def [](nth)
      parse_node(nodes[nth])
    end

    private

      def doc
        Nokogiri::HTML.parse(@html)
      end

      def nodes
        doc.css('.itemListLine > a')
      end

      def parse_node(node)
        return if node.nil?
        hash = {}
        hash.merge!(parse_name_text(node.css('.itemName').text))
        hash.merge!(parse_price_text(node.css('.itemPrice').text))
      end

      def parse_name_text(text)
        %r{【(.+)】《([^/]+)/([^/]+)》}.match(text)
        lang = Regexp.last_match(1)
        name = Regexp.last_match(2)
        english_name = Regexp.last_match(3)
        if lang == 'ENG'
          language = 'english'
        elsif lang == 'JPN'
          language = 'japanese'
        end
        {
          name: name,
          english_name: english_name,
          language: language,
        }
      end

      def parse_price_text(text)
        price = text.gsub(/[^\d]/, '').to_i
        {
          price: price,
        }
      end

  end
end
