# frozen_string_literal: true

require 'nokogiri'

module MtgScraper
  module Hareruya
    module List
      class V2ItemParser

        def initialize(node)
          @node = node
        end

        def parse
          result = {
            name: name,
            english_name: english_name,
            language: language,
            price: price,
            card_set_code: card_set_code,
            foil: foil?,
            basic_land: basic_land?,
            token: token?,
            prerelease: prerelease?,
          }

          unless version.nil?
            result[:version] = version
          end

          result
        end

        def name
          %r{《([^/]+)(/([^/]+))?》}.match(item_name)
          Regexp.last_match(1)
        end

        def english_name
          %r{《([^/]+)(/([^/]+))?》}.match(item_name)
          Regexp.last_match(3)
        end

        def language
          if item_name.match? %r{【EN】}
            language = 'english'
          elsif item_name.match? %r{【JP】}
            language = 'japanese'
          end
        end

        def price
          price_node = node.css('.row.not-first.ng-star-inserted')[0]
          text = price_node.text
          text.match %r{¥ ?[\d,]+}
          Regexp.last_match(0).gsub(/[^\d]/, '').to_i
        end

        def card_set_code
          if item_name.match %r{\[(.+)\]}
            text = Regexp.last_match(1)
          elsif item_name.match %r{［(.+)］}
            text = Regexp.last_match(1)
          end

          if text == 'BOXプロモ' and name == '運命のきずな'
            'M19'
          else
            text.sub('-PRE', '')
          end
        end

        def basic_land?
          CardName.basic_land? name
        end

        def prerelease?
          item_name.match? %r{-PRE\]}
        end

        def token?
          name.end_with? 'トークン'
        end

        def foil?
          item_name.match? %r{【Foil】}
        end

        def version
          if item_name.match %r{■([^■]+)■}
            return Regexp.last_match(1)
          end

          if item_name.match %r{(\w)\[CHK\]}
            return Regexp.last_match(1)
          end
        end

        private

          def node
            @node
          end

          def item_name
            @item_name ||= fix_typo(node.css('.itemName').text.strip)
          end

          def fix_typo(item_name)
            # https://www.hareruyamtg.com/ja/products/search?cardset=128&page=18
            if item_name.match? %r{《平地/Plains[^》]}
              item_name.sub('《平地/Plains', '《平地/Plains》')
            # https://www.hareruyamtg.com/ja/products/search?cardset=163&page=2
            elsif item_name.match? %r{《バラルの功技/Baral's Expertise》}
              item_name.sub("バラルの功技/Baral's Expertise", "バラルの巧技/Baral's Expertise")
            else
              item_name
            end
          end

      end
    end
  end
end
