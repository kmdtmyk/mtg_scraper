# frozen_string_literal: true

RSpec.describe MtgScraper::CardSet do

  describe 'code_from_name' do

    example do
      expect(MtgScraper::CardSet.code_from_name('灯争大戦')).to eq 'WAR'
    end

    example 'invalid' do
      expect(MtgScraper::CardSet.code_from_name('')).to eq nil
      expect(MtgScraper::CardSet.code_from_name(nil)).to eq nil
    end

  end

end
