require 'spec_helper'
require 'wisdom_guild/parse'

RSpec.describe 'Parse' do

  it 'name' do
    expect(WisdomGuild::Parse.name("\n\t\t\t\tセラの天使/Serra Angel\n\t\t\t\t（せらのてんし）\t\t\t")).to eq(
      name: 'セラの天使',
      english_name: 'Serra Angel',
      furigana: 'せらのてんし',
    )

    expect(WisdomGuild::Parse.name(' タルモゴイフ / Tarmogoyf （ たるもごいふ ）')).to eq(
      name: 'タルモゴイフ',
      english_name: 'Tarmogoyf',
      furigana: 'たるもごいふ',
    )
  end

end
