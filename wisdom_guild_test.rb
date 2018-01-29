require 'test/unit'
require_relative 'wisdom_guild'

class WisdomGuildTest < Test::Unit::TestCase

  sub_test_case 'get' do

    test 'Creature' do
      expect = [
        {
          name: '順応する跳ね顎',
          english_name: 'Adaptive Snapjaw',
          furigana: 'じゅんのうするはねあご',
          mana_cost: '(４)(緑)',
          legendary: false,
          types: [
            {
              name: 'クリーチャー',
            },
          ],
          subtypes: [
            {
              name: 'トカゲ',
              english_name: 'Lizard',
            },
            {
              name: 'ビースト',
              english_name: 'Beast',
            },
          ],
          text: "進化（クリーチャー１体があなたのコントロール下で戦場に出るたび、そのクリーチャーのパワーかタフネスがこのクリーチャーよりも大きい場合、このクリーチャーの上に+1/+1カウンターを１個置く。）",
          oracle: "Evolve （Whenever a creature enters the battlefield under your control, if that creature has greater power or toughness than this creature, put a +1/+1 counter on this creature.）",
          size: '6/2',
          power: 6,
          toughness: 2,
          flavor_text: "「あー、カエルがもっと要るな。」 ――― シミックの生術師、グリスタン",
        },
      ]
      assert_equal(expect, WisdomGuild.get('GTC113'))

      expect = [
        {
          name: '熱烈の神ハゾレト',
          english_name: 'Hazoret the Fervent',
          furigana: 'ねつれつのかみはぞれと',
          mana_cost: '(３)(赤)',
          legendary: true,
          types: [
            {
              name: 'クリーチャー',
            },
          ],
          subtypes: [
            {
              name: '神',
              english_name: 'God',
            },
          ],
          text: "破壊不能、速攻\nあなたの手札のカードが１枚以下でないかぎり、熱烈の神ハゾレトでは攻撃したりブロックしたりできない。\n(２)(赤),カード１枚を捨てる：熱烈の神ハゾレトは各対戦相手にそれぞれ２点のダメージを与える。",
          oracle: "Indestructible, haste\nHazoret the Fervent can't attack or block unless you have one or fewer cards in hand.\n{2}{R}, Discard a card: Hazoret deals 2 damage to each opponent.",
          size: '5/4',
          power: 5,
          toughness: 4,
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('AKH136'))
    end

    test 'Instant' do
      expect = [
        {
          name: '取り消し',
          english_name: 'Cancel',
          furigana: 'とりけし',
          mana_cost: '(１)(青)(青)',
          legendary: false,
          types: [
            {
              name: 'インスタント',
            },
          ],
          subtypes: [],
          text: "呪文１つを対象とし、それを打ち消す。",
          oracle: "Counter target spell.",
          flavor_text: "「お前のやりたいことが理屈に逆らってるってことじゃない。 ただ、ものすごく馬鹿げてるってだけだ。」",
        },
      ]
      assert_equal(expect, WisdomGuild.get('ALA033'))
    end

    test 'Sorcery' do
      expect = [
        {
          name: '頭目の乱闘',
          english_name: 'Alpha Brawl',
          furigana: 'とうもくのらんとう',
          mana_cost: '(６)(赤)(赤)',
          legendary: false,
          types: [
            {
              name: 'ソーサリー',
            },
          ],
          subtypes: [],
          text: "対戦相手１人がコントロールするクリーチャー１体を対象とする。それは自身のパワーに等しい点数のダメージを、そのプレイヤーがコントロールする他の各クリーチャーにそれぞれ与える。その後、それらの各クリーチャーは、それぞれのパワーに等しい点数のダメージをそのクリーチャーに与える。",
          oracle: "Target creature an opponent controls deals damage equal to its power to each other creature that player controls, then each of those creatures deals damage equal to its power to that creature.",
          flavor_text: "頭目であることは、満月のたびにそれを証明しなければいけないことだ。",
        },
      ]
      assert_equal(expect, WisdomGuild.get('DKA082'))
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
