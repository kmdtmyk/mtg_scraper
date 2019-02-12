# frozen_string_literal: true

require 'open-uri'

module MtgScraper
  module Utils
    module HtmlUtil
      module_function

      def self.get(url)
        html = open(url) do |f|
          f.read
        end
        html
      end

    end
  end
end
