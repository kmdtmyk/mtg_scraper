# frozen_string_literal: true

RSpec.describe CardSet do

  describe 'code_from_name' do

    example do
      expect(CardSet.code_from_name('灯争大戦')).to eq 'WAR'
    end

    example 'invalid' do
      expect(CardSet.code_from_name('')).to eq nil
      expect(CardSet.code_from_name(nil)).to eq nil
    end

  end

end
