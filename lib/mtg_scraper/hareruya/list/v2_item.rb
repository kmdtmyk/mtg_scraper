# frozen_string_literal: true

require 'nokogiri'

module MtgScraper
  module Hareruya
    module List
      class V2Item

        def initialize(node, list)
          @node = node
          @list = list
        end

        def to_h
          {
            name: name,
            english_name: english_name,
            language: language,
            price: price,
            card_set_code: card_set_code,
            foil: foil?,
            basic_land: basic_land?,
            token: token?,
            prerelease: prerelease?,
            version: version,
          }
        end

        def name
          %r{《([^/]+)(/([^/]+))?》}.match(item_name)
          text = Regexp.last_match(1)
          if text == 'トークン（パンチカード）'
            'パンチカード'
          else
            text
          end
        end

        def english_name
          %r{《([^/]+)(/([^/]+))?》}.match(item_name)
          text = Regexp.last_match(3)
          if text.nil?
            return
          end
          text.gsub('’', '\'')
            .gsub(/,[^ ]/){ |s|
              # insert space after comma
              "#{s[0]} #{s[1]}"
            }
        end

        def language
          if item_name.match? %r{【EN】}
            language = 'English'
          elsif item_name.match? %r{【JP】}
            language = 'Japanese'
          end
        end

        def price
          return unless node.text.match? %r{¥ [\d,]+}
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

          if text.nil?
            CardSet.code_from_name @list.params[:card_set_name]
          elsif text == 'BOXプロモ'
            {
              '運命のきずな' => 'M19',
              '橋の主、テゼレット' => 'WAR',
            }[name]
          else
            text.sub(%r{-(PRE|PW)等?}, '')
          end
        end

        def basic_land?
          CardName.basic_land? name
        end

        def prerelease?
          item_name.match? %r{-PRE\]}
        end

        def token?
          item_name.match? %r{トークン}
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
            item_name = item_name.sub('[10ED]', '[10E]')

            # https://www.hareruyamtg.com/ja/products/search?cardset=128&page=18
            if item_name.match? %r{《平地/Plains[^》]}
              item_name.sub('《平地/Plains', '《平地/Plains》')
            # https://www.hareruyamtg.com/ja/products/search?cardset=163&page=2
            elsif item_name.match? %r{《バラルの功技/Baral's Expertise》}
              item_name.sub("バラルの功技/Baral's Expertise", "バラルの巧技/Baral's Expertise")
            elsif item_name.match? %r{第1管区}
              item_name.sub('第1管区', '第１管区')
            else
              item_name
            end
          end

      end
    end
  end
end
