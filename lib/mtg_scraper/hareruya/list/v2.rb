# frozen_string_literal: true

require 'nokogiri'

module MtgScraper
  module Hareruya
    module List
      class V2
        include Enumerable

        def initialize(html)
          @html = html
        end

        def each
          item_nodes.each do |node|
            yield parse_node(node)
          end
        end

        def size
          item_nodes.size
        end

        def params
          result = {}

          unless selected_card_set_name.nil?
            result[:card_set_name] = selected_card_set_name
          end

          result
        end

        def [](nth)
          item_nodes = doc.css('.itemListLine.itemListLine--searched li')[nth]
          if item_nodes.is_a? Nokogiri::XML::NodeSet
            item_nodes.map{ |node| parse_node(node) }
          else
            parse_node(item_nodes)
          end
        end

        def category_list
          doc.css('.category_menu .category_key').map do |node|
            {
              name: category_name(node),
              id: category_id(node),
            }
          end
        end

        def next_page_url
          node = doc.css('.result_pagenum')
          if node.css('.now_').empty?
            node.css('a')[0][:href]
          else
            node.css('.now_ + a')[0][:href]
          end
        rescue
          nil
        end

        def total_page
          match_data = doc.css('.result_pagenum').text.match(/([\d]+)ページ中/)
          match_data[1].to_i
        rescue
          nil
        end

        private

          def parse_node(node)
            V2Item.new(node).to_h
          end

          def category_id(node)
            link = node.css('a[href*="cardset="]')[0]
            href = link[:href]
            match_data = href.match(/cardset=([\d]+)/)
            id = match_data[1].to_i
          rescue
            nil
          end

          def category_name(node)
            name = node.css('h5').text.strip
          rescue
            nil
          end

          def doc
            @doc ||= Nokogiri::HTML(@html)
          end

          def item_nodes
            doc.css('.itemListLine.itemListLine--searched li')
          end

          def selected_card_set_name
            @selected_card_set_name ||= begin
              node = doc.css('#front_product_search_cardset option[selected]')
              node.text if node.any?
            end
          end

      end
    end
  end
end
