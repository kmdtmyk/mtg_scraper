require 'spec_helper'
require 'wisdom_guild/card'

RSpec.describe 'Card' do

  it 'Creature' do
    details = [
      {
        name: 'セラの天使',
        english_name: 'Serra Angel',
        furigana: 'せらのてんし',
        mana_cost: '(３)(白)(白)',
        supertypes: [],
        types: [
          { name: 'クリーチャー' },
        ],
        subtypes: [
          { name: '天使', english_name: 'Angel' },
        ],
        text: "飛行\n警戒（このクリーチャーは攻撃してもタップしない。）",
        oracle: "Flying （This creature can't be blocked except by creatures with flying or reach.）\nVigilance （Attacking doesn't cause this creature to tap.）",
        power: "4",
        toughness: "4",
        flavor_text: "彼女の剣はどんな聖歌隊よりも美しく歌う。",
        artists: [
          { english_name: "Greg Staples" },
        ],
      },
    ]
    expect(WisdomGuild::Card.get('10E039')[:details]).to match(details)
  end

end
