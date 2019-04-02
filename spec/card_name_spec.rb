# frozen_string_literal: true

RSpec.describe CardName do

  describe 'basic_land?' do

    example 'true' do
      names = [
        '平地',
        '島',
        '沼',
        '山',
        '森',
        '荒地',
        'Plains',
        'Island',
        'Swamp',
        'Mountain',
        'Forest',
        'Wastes',
      ]
      names.each do |name|
        expect(CardName.basic_land?(name)).to eq true
      end
    end

    example 'false' do
      names = [
        '蒸気孔',
        '',
        nil,
      ]
      names.each do |name|
        expect(CardName.basic_land?(name)).to eq false
      end
    end

  end

end
