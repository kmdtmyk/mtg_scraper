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
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: 'トカゲ', english_name: 'Lizard' },
            { name: 'ビースト', english_name: 'Beast' },
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
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: '神', english_name: 'God' },
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

      expect = [
        {
          name: 'タルモゴイフ',
          english_name: 'Tarmogoyf',
          furigana: 'たるもごいふ',
          mana_cost: '(１)(緑)',
          legendary: false,
          types: [
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: 'ルアゴイフ', english_name: 'Lhurgoyf' },
          ],
          text: "タルモゴイフのパワーは、すべての墓地にあるカードのカード・タイプの数に等しく、タフネスはその点数に１を加えた点数に等しい。",
          oracle: "Tarmogoyf's power is equal to the number of card types among cards in all graveyards and its toughness is equal to that number plus 1.",
          size: '*/1+*',
          power: 0,
          toughness: 1,
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('FUT153'))
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
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "呪文１つを対象とし、それを打ち消す。",
          oracle: "Counter target spell.",
          flavor_text: "「お前のやりたいことが理屈に逆らってるってことじゃない。 ただ、ものすごく馬鹿げてるってだけだ。」",
        },
      ]
      assert_equal(expect, WisdomGuild.get('ALA033'))

      expect = [
        {
          name: '否定の契約',
          english_name: "Pact of Negation",
          furigana: "ひていのけいやく",
          mana_cost: '(０)',
          color: '青',
          legendary: false,
          types: [
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "呪文１つを対象とし、それを打ち消す。\nあなたの次のアップキープの開始時に(３)(青)(青)を支払う。そうしない場合、あなたはこのゲームに敗北する。",
          oracle: "Counter target spell.\nAt the beginning of your next upkeep, pay {3}{U}{U}. If you don't, you lose the game.",
          flavor_text: "常に裏切りを予測する者が落胆することはまず無い。",
        },
      ]
      assert_equal(expect, WisdomGuild.get('FUT042'))
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
            { name: 'ソーサリー' },
          ],
          subtypes: [],
          text: "対戦相手１人がコントロールするクリーチャー１体を対象とする。それは自身のパワーに等しい点数のダメージを、そのプレイヤーがコントロールする他の各クリーチャーにそれぞれ与える。その後、それらの各クリーチャーは、それぞれのパワーに等しい点数のダメージをそのクリーチャーに与える。",
          oracle: "Target creature an opponent controls deals damage equal to its power to each other creature that player controls, then each of those creatures deals damage equal to its power to that creature.",
          flavor_text: "頭目であることは、満月のたびにそれを証明しなければいけないことだ。",
        },
      ]
      assert_equal(expect, WisdomGuild.get('DKA082'))

      expect = [
        {
          name: "祖先の幻視",
          english_name: "Ancestral Vision",
          furigana: "そせんのげんし",
          mana_cost: "",
          legendary: false,
          color: '青',
          types: [
            { name: 'ソーサリー' },
          ],
          subtypes: [],
          text: "待機４ ― (青)（このカードをあなたの手札から唱えるのではなく、(青)を支払うとともにそれを時間(time)カウンターが４個置かれた状態で追放する。あなたのアップキープの開始時に、時間カウンターを１個取り除く。最後の１個を取り除いたとき、それをそのマナ・コストを支払うことなく唱える。）\nプレイヤー１人を対象とする。そのプレイヤーはカードを３枚引く。",
          oracle: "Suspend 4 --- {U} （Rather than cast this card from your hand, pay {U} and exile it with four time counters on it. At the beginning of your upkeep, remove a time counter. When the last is removed, cast it without paying its mana cost.）\nTarget player draws three cards.",
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('IMA042'))
    end

    test 'Enchantment' do
      expect = [
        {
          name: '拘引',
          english_name: 'Arrest',
          furigana: 'こういん',
          mana_cost: '(２)(白)',
          legendary: false,
          types: [
            { name: 'エンチャント' },
          ],
          subtypes: [
            { name: 'オーラ', english_name: 'Aura' },
          ],
          text: "エンチャント（クリーチャー）\nエンチャントされているクリーチャーは攻撃もブロックもできず、その起動型能力を起動できない。",
          oracle: "Enchant creature\nEnchanted creature can't attack or block, and its activated abilities can't be activated.",
          flavor_text: "「あんたの罪なら立証してやるわ。うちらが無実の者を拘引するわけないでしょ。」――― 第10管区の拘引者、ラヴィニア.",
        },
      ]
      assert_equal(expect, WisdomGuild.get('RTR003'))
    end

    test 'Artifact' do
      expect = [
        {
          name: 'アクローマの記念碑',
          english_name: "Akroma's Memorial",
          furigana: 'あくろーまのきねんひ',
          mana_cost: '(７)',
          legendary: true,
          types: [
            { name: 'アーティファクト' },
          ],
          subtypes: [],
          text: "あなたがコントロールするクリーチャーは飛行、先制攻撃、警戒、トランプル、速攻、プロテクション（黒）とプロテクション（赤）を持つ。",
          oracle: "Creatures you control have flying, first strike, vigilance, trample, haste, and protection from black and from red.",
          flavor_text: "「休息も慈悲も与えぬ。何があってもだ。」 ――― 碑文",
        },
      ]
      assert_equal(expect, WisdomGuild.get('M13200'))

      expect = [
        {
          name: '金属製の巨像',
          english_name: "Metalwork Colossus",
          furigana: 'きんぞくせいのきょぞう',
          mana_cost: '(１１)',
          legendary: false,
          types: [
            { name: 'アーティファクト' },
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: '構築物', english_name: 'Construct' },
          ],
          text: "金属製の巨像を唱えるためのコストは(Ｘ)少なくなる。Ｘはあなたがコントロールするクリーチャーでないアーティファクトの点数で見たマナ・コストの合計に等しい。\nアーティファクトを２つ生け贄に捧げる：あなたの墓地から金属製の巨像をあなたの手札に戻す。",
          oracle: "Metalwork Colossus costs {X} less to cast, where X is the total converted mana cost of noncreature artifacts you control.\nSacrifice two artifacts: Return Metalwork Colossus from your graveyard to your hand.",
          size: '10/10',
          power: 10,
          toughness: 10,
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('KLD222'))

      expect = [
        {
          name: '領事の旗艦、スカイソブリン',
          english_name: "Skysovereign, Consul Flagship",
          furigana: 'りょうじのきかんすかいそぶりん',
          mana_cost: '(５)',
          legendary: true,
          types: [
            { name: 'アーティファクト' },
          ],
          subtypes: [
            { name: '機体', english_name: 'Vehicle' },
          ],
          text: "飛行\n領事の旗艦、スカイソブリンが戦場に出るか攻撃するたび、対戦相手がコントロールするクリーチャー１体かプレインズウォーカー１体を対象とする。領事の旗艦、スカイソブリンはそれに３点のダメージを与える。\n搭乗３（あなたがコントロールする望む数のクリーチャーを、パワーの合計が３以上になるように選んでタップする：ターン終了時まで、この機体(Vehicle)はアーティファクト・クリーチャーになる。）",
          oracle: "Flying\nWhenever Skysovereign, Consul Flagship enters the battlefield or attacks, it deals 3 damage to target creature or planeswalker an opponent controls.\nCrew 3 （Tap any number of creatures you control with total power 3 or more: This Vehicle becomes an artifact creature until end of turn.）",
          size: '6/5',
          power: 6,
          toughness: 5,
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('KLD234'))
    end

    test 'Planeswalker' do
      expect = [
        {
          name: 'ジェイス・ベレレン',
          english_name: "Jace Beleren",
          furigana: 'じぇいすべれれん',
          mana_cost: '(１)(青)(青)',
          legendary: true,
          types: [
            { name: 'プレインズウォーカー' },
          ],
          subtypes: [
            { name: 'ジェイス', english_name: 'Jace' },
          ],
          text: "[+2]：各プレイヤーはカードを１枚引く。\n[-1]：プレイヤー１人を対象とする。そのプレイヤーはカードを１枚引く。\n[-10]：プレイヤー１人を対象とする。そのプレイヤーは、自分のライブラリーのカードを上から２０枚、自分の墓地に置く。",
          oracle: "+2: Each player draws a card.\n-1: Target player draws a card.\n-10: Target player puts the top twenty cards of his or her library into his or her graveyard.",
          size: '3',
          loyalty: 3,
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('M11058'))

      expect = [
        {
          name: '自然に仕える者、ニッサ',
          english_name: "Nissa, Steward of Elements",
          furigana: 'しぜんにつかえるものにっさ',
          mana_cost: '(Ｘ)(緑)(青)',
          legendary: true,
          types: [
            { name: 'プレインズウォーカー' },
          ],
          subtypes: [
            { name: 'ニッサ', english_name: 'Nissa' },
          ],
          text: "[+2]：占術２を行う。\n[0]：あなたのライブラリーの一番上のカードを見る。それが土地カードであるか、点数で見たマナ・コストが自然に仕える者、ニッサの上に置かれている忠誠(loyalty)カウンターの総数以下であるクリーチャー・カードであるなら、あなたはそのカードを戦場に出してもよい。\n[-6]：あなたがコントロールする土地最大２つを対象とし、それらをアンタップする。ターン終了時まで、それらは飛行と速攻を持つ5/5のエレメンタル(Elemental)・クリーチャーになる。それらは土地でもある。",
          oracle: "+2: Scry 2.\n0: Look at the top card of your library. If it's a land card or a creature card with converted mana cost less than or equal to the number of loyalty counters on Nissa, Steward of Elements, you may put that card onto the battlefield.\n-6: Untap up to two target lands you control. They become 5/5 Elemental creatures with flying and haste until end of turn. They're still lands.",
          size: 'X',
          loyalty: 0,
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('AKH204'))
    end

    test 'Land' do
      expect = [
        {
          name: '平地',
          english_name: "Plains",
          furigana: 'へいち',
          mana_cost: '',
          legendary: false,
          basic: true,
          types: [
            { name: '土地' },
          ],
          subtypes: [
            { name: '平地', english_name: 'Plains' },
          ],
          text: "(白)",
          oracle: "W",
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('RIX192'))

      expect = [
        {
          name: '荒地',
          english_name: "Wastes",
          furigana: 'あれち',
          mana_cost: '',
          legendary: false,
          basic: true,
          types: [
            { name: '土地' },
          ],
          subtypes: [],
          text: "(Ｔ)：あなたのマナ・プールに(◇)を加える。",
          oracle: "{T}: Add {C} to your mana pool.",
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('OGW183'))

      expect = [
        {
          name: '蒸気孔',
          english_name: "Steam Vents",
          furigana: 'じょうきこう',
          mana_cost: '',
          legendary: false,
          types: [
            { name: '土地' },
          ],
          subtypes: [
            { name: '島', english_name: 'Island' },
            { name: '山', english_name: 'Mountain' },
          ],
          text: "（(Ｔ)：あなたのマナ・プールに(青)か(赤)を加える）\n蒸気孔が戦場に出るに際し、あなたは２点のライフを支払ってもよい。そうしなかった場合、蒸気孔はタップ状態で戦場に出る。",
          oracle: "（{T}: Add {U} or {R} to your mana pool.）\nAs Steam Vents enters the battlefield, you may pay 2 life. If you don't, Steam Vents enters the battlefield tapped.",
          flavor_text: "才能により形作られ、狂気により活性化したもの。",
        },
      ]
      assert_equal(expect, WisdomGuild.get('RTR247'))

      expect = [
        {
          name: 'ドライアドの東屋',
          english_name: "Dryad Arbor",
          furigana: 'どらいあどのあずまや',
          mana_cost: '',
          legendary: false,
          color: '緑',
          types: [
            { name: '土地' },
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: '森', english_name: 'Forest' },
            { name: 'ドライアド', english_name: 'Dryad' },
          ],
          text: "（ドライアドの東屋は呪文ではなく、召喚酔いの影響を受け、「(Ｔ)：あなたのマナ・プールに(緑)を加える。」を持つ。）",
          oracle: "（Dryad Arbor isn't a spell, it's affected by summoning sickness, and it has \"{T}: Add {G} to your mana pool.\"）",
          size: '1/1',
          power: 1,
          toughness: 1,
          flavor_text: "樹触れるべからず、枝折るべからず、答を望む問いのみを発せよ。――― ドルイドの古老、ヴォン・ヨムから彼女の信徒へ.",
        },
      ]
      assert_equal(expect, WisdomGuild.get('FUT174'))
    end

    test 'split' do
      expect = [
        {
          name: '火',
          english_name: "Fire",
          furigana: 'ひ',
          mana_cost: '(１)(赤)',
          legendary: false,
          types: [
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "１つか２つのクリーチャーとプレイヤーの組み合わせを対象とする。火は、それらに２点のダメージを望むように割り振って与える。",
          oracle: "Fire deals 2 damage divided as you choose among one or two target creatures and/or players.",
          flavor_text: "",
        },
        {
          name: '氷',
          english_name: "Ice",
          furigana: 'こおり',
          mana_cost: '(１)(青)',
          legendary: false,
          types: [
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "パーマネント１つを対象とし、それをタップする。\nカードを１枚引く。",
          oracle: "Tap target permanent.\nDraw a card.",
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('APC128'))

      expect = [
        {
          name: '摩耗',
          english_name: "Wear",
          furigana: 'まもう',
          mana_cost: '(１)(赤)',
          legendary: false,
          types: [
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "アーティファクト１つを対象とし、それを破壊する。\n融合（あなたはこのカードの片方の半分または両方の半分をあなたの手札から唱えてもよい。）",
          oracle: "Destroy target artifact.\nFuse （You may cast one or both halves of this card from your hand.）",
          flavor_text: "",
        },
        {
          name: '損耗',
          english_name: "Tear",
          furigana: 'そんもう',
          mana_cost: '(白)',
          legendary: false,
          types: [
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "エンチャント１つを対象とし、それを破壊する。\n融合（あなたはこのカードの片方の半分または両方の半分をあなたの手札から唱えてもよい。）",
          oracle: "Destroy target enchantment.\nFuse （You may cast one or both halves of this card from your hand.）",
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('DGM135'))

      expect = [
        {
          name: '木端',
          english_name: "Cut",
          furigana: 'こっぱ',
          mana_cost: '(１)(赤)',
          legendary: false,
          types: [
            { name: 'ソーサリー' },
          ],
          subtypes: [],
          text: "クリーチャー１体を対象とする。木端はそれに４点のダメージを与える。",
          oracle: "Cut deals 4 damage to target creature.",
          flavor_text: "",
        },
        {
          name: '微塵',
          english_name: "Ribbons",
          furigana: 'みじん',
          mana_cost: '(Ｘ)(黒)(黒)',
          legendary: false,
          types: [
            { name: 'ソーサリー' },
          ],
          subtypes: [],
          text: "余波（この呪文はあなたの墓地からのみ唱えられる。その後、これを追放する。）\n各対戦相手はそれぞれＸ点のライフを失う。",
          oracle: "Aftermath （Cast this spell only from your graveyard. Then exile it.）\nEach opponent loses X life.",
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('AKH223'))
    end

    test 'levelup' do
      expect = [
        {
          name: 'グール・ドラズの暗殺者',
          english_name: "Guul Draz Assassin",
          furigana: 'ぐーるどらずのあんさつしゃ',
          mana_cost: '(黒)',
          legendary: false,
          types: [
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: '吸血鬼', english_name: 'Vampire' },
            { name: '暗殺者', english_name: 'Assassin' },
          ],
          text: "Ｌｖアップ(１)(黒)（(１)(黒)：この上にＬｖ(level)カウンターを１個置く。Ｌｖアップはソーサリーとしてのみ行う。）\nLv 2-3\n2/2\n(黒),(Ｔ)：クリーチャー１体を対象とする。それはターン終了時まで-2/-2の修整を受ける。\nLv 4+\n4/4\n(黒),(Ｔ)：クリーチャー１体を対象とする。それはターン終了時まで-4/-4の修整を受ける。",
          oracle: "Level up {1}{B} （{1}{B}: Put a level counter on this. Level up only as a sorcery.）\nLEVEL 2-3\n2/2\n{B}, {T}: Target creature gets -2/-2 until end of turn.\nLEVEL 4+\n4/4\n{B}, {T}: Target creature gets -4/-4 until end of turn.",
          size: '1/1',
          power: 1,
          toughness: 1,
          flavor_text: "",
        },
      ]
      assert_equal(expect, WisdomGuild.get('ROE112'))
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
