module WisdomGuild

  class ParseText

    def self.name(text)
      %r{([^/\n\t]+)\/([^/\n\t（）]+)[\s]*(（(.+)）)?}.match(text)
      name_text = Regexp.last_match(1)
      english_name_text = Regexp.last_match(2)
      furigana_text = Regexp.last_match(4)
      result = {}
      result[:name] = name_text.strip
      result[:english_name] = english_name_text.strip
      result[:furigana] = furigana_text.strip unless furigana_text.nil?
      result
    end

    def self.mana_cost(text)
      {
        mana_cost: text.strip
      }
    end

    def self.type(text)
      %r{(〔(.*)〕 )?(伝説の|基本|氷雪|持続|精鋭|宿主|ワールド・)*(\S+)( — (\S+))?}.match(text)
      color_text = Regexp.last_match(2)
      supertype_text = Regexp.last_match(3)
      type_text = Regexp.last_match(4)
      subtype_text = Regexp.last_match(6)

      supertypes = []
      types = []
      subtypes = []

      supertypes << { name: '伝説の' } if %r{伝説の}.match(text)
      supertypes << { name: '基本' } if %r{基本}.match(text)
      supertypes << { name: '氷雪' } if %r{氷雪}.match(text)
      supertypes << { name: 'ワールド' } if %r{ワールド}.match(text)

      unless type_text.nil?
        type_text.gsub!('部族', '部族・') if %r{部族[^・]}.match(type_text)
        type_text.split('・').each do |type|
          types << { name: type }
        end
      end

      unless subtype_text.nil?
        subtype_text.split('・').each do |subtype|
          %r{(\S+)?\((\S+)\)}.match(subtype)
          subtypes << {
            name: Regexp.last_match(1) || '',
            english_name: Regexp.last_match(2),
          }
        end
      end

      result = {
        supertypes: supertypes,
        types: types,
        subtypes: subtypes,
      }

      unless color_text.nil?
        result[:colors] = color_text.split('/').map do |color|
          { name: color }
        end
      end

      result
    end

    def self.text(text)
      {
        text: text.strip,
      }
    end

    def self.oracle(text)
      {
        oracle: text.strip,
      }
    end

    def self.size(text)
      %r{(.*)/(.*)}.match(text)
      power = Regexp.last_match(1)
      toughness = Regexp.last_match(2)
      {
        power: power,
        toughness: toughness,
      }
    end

    def self.loyalty(text)
      {
        loyalty: text.strip,
      }
    end

    def self.flavor_text(text)
      {
        flavor_text: text.strip,
      }
    end

    def self.artist(text)
      {
        artists: text.strip.split(' & ').map{ |name| { english_name: name } }
      }
    end

  end

end
