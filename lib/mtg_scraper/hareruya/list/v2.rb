# frozen_string_literal: true

require 'nokogiri'

module MtgScraper
  module Hareruya
    module List
      class V2

        def initialize(html)
          @html = html
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
            Nokogiri::HTML(@html)
          end

      end
    end
  end
end
