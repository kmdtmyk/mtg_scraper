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
        parse_item_name(node.css('.itemName').text)
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
