# frozen_string_literal: true

require 'nokogiri'

module MtgScraper
  module Hareruya
    module List
      class V1Item

        def initialize(node)
          @node = node
        end

        def to_h
          {
            name: name,
            english_name: english_name,
            language: language,
            price: price,
            card_set_code: card_set_code,
            basic_land: basic_land?,
          }
        end

        def name
          %r{《([^/]+)/([^/]+)》}.match(item_name)
          Regexp.last_match(1)
        end

        def english_name
          %r{《([^/]+)/([^/]+)》}.match(item_name)
          Regexp.last_match(2)
        end

        def language
          if item_name.match? %r{【ENG】}
            'english'
          elsif item_name.match? %r{【JPN】}
            'japanese'
          end
        end

        def price
          text = node.css('.itemPrice').text
          text.gsub(/[^\d]/, '').to_i
        end

        def card_set_code
          item_name.match %r{\[(.+)\]}
          Regexp.last_match(1)
        end

        def basic_land?
          CardName.basic_land? name
        end

        private

          def node
            @node
          end

          def item_name
            @item_name ||= node.css('.itemName').text
          end

      end
    end
  end
end
