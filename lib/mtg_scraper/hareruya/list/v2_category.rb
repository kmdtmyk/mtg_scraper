# frozen_string_literal: true

require 'nokogiri'

module MtgScraper
  module Hareruya
    module List
      class V2Category

        def initialize(node)
          @node = node
        end

        def to_h
          {
            id: id,
            name: name,
            code: code,
          }
        end

        def id
          link = @node.css('a[href*="cardset="]')[0]
          href = link[:href]
          match_data = href.match(/cardset=([\d]+)/)
          id = match_data[1].to_i
        rescue
          nil
        end

        def name
          name = @node.css('h5').text.strip
        rescue
          nil
        end

        def code
          box_node = @node.css('li.category_tree2_').find do |node|
            node.text.include? 'パック・ボックス'
          end
          url = @node.css('a').attr('href').text
          params = URI::decode_www_form(URI.parse(url).query).to_h
          params['product'][1..-2]
        rescue
          nil
        end

      end
    end
  end
end
