# frozen_string_literal: true

require 'nokogiri'

module MtgScraper
  module Hareruya
    module List
      class V1
        include Enumerable

        def initialize(html)
          @html = html
        end

        def card_set_name
          doc.css('#bread-crumb-list li:nth-child(2) a').text
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
          element = nodes[nth]
          if element.is_a? Nokogiri::XML::NodeSet
            element.map{ |node| parse_node(node) }
          else
            parse_node(element)
          end
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
            V1Item.new(node).to_h
          end

      end
    end
  end
end
