# frozen_string_literal: true

require 'open-uri'

module MtgScraper

  module Utils

    class HtmlUtil

      def self.get(url)
        html = open(url) do |f|
          f.read
        end
        html
      end

    end

  end

end
