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
      assert_equal(expect, WisdomGuild.parse(html))
    end

  end

  test 'get_layout' do
    test_cases = [
      {card: 'XLN179', layout: 'normal', name: '殺戮の暴君'},
      {card: 'AER031', layout: 'normal', name: '不許可'},
      {card: 'EMN133', layout: 'normal', name: '焼夷流'},
      {card: 'RIX092', layout: 'normal', name: '血染めの太陽'},
      {card: 'KLD220', layout: 'normal', name: '街の鍵'},
      {card: 'KLD242', layout: 'normal', name: '霊気拠点'},
      {card: 'HOU140', layout: 'normal', name: '王神、ニコル・ボーラス'},

      {card: 'ORI060', layout: 'double_faced', name: 'ヴリンの神童、ジェイス'},
      {card: 'XLN191', layout: 'double_faced', name: 'イトリモクの成長儀式'},
      {card: 'XLN074', layout: 'double_faced', name: 'アズカンタの探索'},

      {card: 'EMN015', layout: 'double_faced', name: '消えゆく光、ブルーナ'},
      {card: 'EMN028', layout: 'normal', name: '折れた刃、ギセラ'},

      {card: 'AKH210', layout: 'split', name: '黄昏+払暁'},
      {card: 'DGM124', layout: 'split', name: '強行+突入'},

      {card: 'CHK070', layout: 'flip', name: '呪師の弟子'},
      {card: 'SOK027', layout: 'flip', name: '上位の狐、呪之尾'},

      {card: 'ROE112', layout: 'levelup', name: 'グール・ドラズの暗殺者'},
      {card: 'ROE075', layout: 'levelup', name: '灯台の年代学者'},
    ]
    test_cases.each do |test_case|
      html = WisdomGuild.get_html_and_cache(test_case[:card])
      assert_equal(test_case[:layout], WisdomGuild.get_layout(html), test_case[:name])
    end
  end

end
