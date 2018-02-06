require 'spec_helper'
require 'wisdom_guild/parse_text'

RSpec.describe 'Parse' do

  it 'name' do
    expect(WisdomGuild::ParseText.name("\n\t\t\t\tセラの天使/Serra Angel\n\t\t\t\t（せらのてんし）\t\t\t")).to eq(
      name: 'セラの天使',
      english_name: 'Serra Angel',
      furigana: 'せらのてんし',
    )
    expect(WisdomGuild::ParseText.name('甲鱗のワーム/Scaled Wurm')).to eq(
      name: '甲鱗のワーム',
      english_name: 'Scaled Wurm',
    )
  end

end
