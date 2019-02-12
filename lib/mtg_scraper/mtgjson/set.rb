# frozen_string_literal: true

require 'json'

module MtgScraper::Mtgjson
  class Set
    include Enumerable

    def initialize(text)
      @text = text
    end

    def each
      json[:cards].each do |card|
        yield card
      end
    end

    def size
      json[:cards].size
    end

    def [](nth)
      json[:cards][nth]
    end

    private

      def json
        JSON.parse(@text, symbolize_names: true)
      end

  end
end
