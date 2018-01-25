require 'test/unit'
require_relative 'wisdom_guild'

class WisdomGuildTest < Test::Unit::TestCase

  sub_test_case 'Creature' do

    test '殺戮の暴君' do
      html = WisdomGuild.get_html_and_cache('XLN179')
      expect = [
        {
          name: '殺戮の暴君',
          english_name: 'Carnage Tyrant',
          furigana: 'さつりくのぼうくん',
          mana_cost: '(４)(緑)(緑)',
          legendary: false,
          types: [
            {
              name: 'クリーチャー',
            },
          ],
          subtypes: [
            {
              name: '恐竜',
              english_name: 'Dinosaur',
            },
          ],
          text: "殺戮の暴君は打ち消されない。\nトランプル、呪禁",
          oracle: "Carnage Tyrant can't be countered.\nTrample, hexproof",
          size: '7/6',
          power: 7,
          toughness: 6,
          flavor_text: '',
        },
      ]
      assert_equal(expect, WisdomGuild.normal(html))
    end

  end

end
