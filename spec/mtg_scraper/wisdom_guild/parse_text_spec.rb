require 'spec_helper'
require 'mtg_scraper/wisdom_guild'

RSpec.describe 'ParseText' do

  it 'name' do
    expect(MtgScraper::WisdomGuild::ParseText.name("\n\t\t\t\tセラの天使/Serra Angel\n\t\t\t\t（せらのてんし）\t\t\t")).to eq(
      name: 'セラの天使',
      english_name: 'Serra Angel',
      furigana: 'せらのてんし',
    )
    expect(MtgScraper::WisdomGuild::ParseText.name('甲鱗のワーム/Scaled Wurm')).to eq(
      name: '甲鱗のワーム',
      english_name: 'Scaled Wurm',
    )
  end

end
