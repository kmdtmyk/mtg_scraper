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
        html.force_encoding('UTF-8')
      end

    end
  end
end
