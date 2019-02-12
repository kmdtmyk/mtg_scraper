# frozen_string_literal: true

module MtgScraper
  module WisdomGuild
    class Detail

      attr_reader :name
      attr_reader :english_name
      attr_reader :furigana
      attr_reader :mana_cost
      attr_reader :colors
      attr_reader :supertypes
      attr_reader :types
      attr_reader :subtypes
      attr_reader :text
      attr_reader :oracle
      attr_reader :power
      attr_reader :toughness
      attr_reader :loyalty
      attr_reader :flavor_text
      attr_reader :artists

      def initialize(hash)
        @hash = hash
        hash.each do |name, value|
          instance_variable_set("@#{name}", value)
        end
      end

      def to_hash
        @hash
      end

    end
  end
end
