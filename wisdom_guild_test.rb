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
          supertypes: [],
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
          artist: "Tomasz Jedruszek",
        },
      ]
      assert_equal(expect, WisdomGuild.get('GTC113'))

      expect = [
        {
          name: '熱烈の神ハゾレト',
          english_name: 'Hazoret the Fervent',
          furigana: 'ねつれつのかみはぞれと',
          mana_cost: '(３)(赤)',
          supertypes: [
            { name: '伝説の' },
          ],
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
          artist: "Chase Stone",
        },
      ]
      assert_equal(expect, WisdomGuild.get('AKH136'))

      expect = [
        {
          name: 'タルモゴイフ',
          english_name: 'Tarmogoyf',
          furigana: 'たるもごいふ',
          mana_cost: '(１)(緑)',
          supertypes: [],
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
          artist: "Justin Murray",
        },
      ]
      assert_equal(expect, WisdomGuild.get('FUT153'))

      expect = [
        {
          name: "解き放たれし者、オブ・ニクシリス",
          english_name: "Ob Nixilis, Unshackled",
          furigana: "ときはなたれしものおぶにくしりす",
          mana_cost: '(４)(黒)(黒)',
          supertypes: [
            { name: '伝説の' },
          ],
          types: [
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: 'デーモン', english_name: 'Demon' },
          ],
          text: "飛行、トランプル\n対戦相手１人が自分のライブラリーを探すたび、そのプレイヤーはクリーチャーを１体生け贄に捧げ、１０点のライフを失う。\n他のクリーチャーが１体死亡するたび、解き放たれし者、オブ・ニクシリスの上に+1/+1カウンターを１個置く。",
          oracle: "Flying, trample\nWhenever an opponent searches his or her library, that player sacrifices a creature and loses 10 life.\nWhenever another creature dies, put a +1/+1 counter on Ob Nixilis, Unshackled.",
          size: '4/4',
          power: 4,
          toughness: 4,
          flavor_text: "",
          artist: "Karl Kopinski",
        },
      ]
      assert_equal(expect, WisdomGuild.get('M15110'))
    end

    test 'Instant' do
      expect = [
        {
          name: '取り消し',
          english_name: 'Cancel',
          furigana: 'とりけし',
          mana_cost: '(１)(青)(青)',
          supertypes: [],
          types: [
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "呪文１つを対象とし、それを打ち消す。",
          oracle: "Counter target spell.",
          flavor_text: "「お前のやりたいことが理屈に逆らってるってことじゃない。 ただ、ものすごく馬鹿げてるってだけだ。」",
          artist: "David Palumbo",
        },
      ]
      assert_equal(expect, WisdomGuild.get('ALA033'))

      expect = [
        {
          name: '否定の契約',
          english_name: "Pact of Negation",
          furigana: "ひていのけいやく",
          mana_cost: '(０)',
          colors: [
            { name: '青' },
          ],
          supertypes: [],
          types: [
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "呪文１つを対象とし、それを打ち消す。\nあなたの次のアップキープの開始時に(３)(青)(青)を支払う。そうしない場合、あなたはこのゲームに敗北する。",
          oracle: "Counter target spell.\nAt the beginning of your next upkeep, pay {3}{U}{U}. If you don't, you lose the game.",
          flavor_text: "常に裏切りを予測する者が落胆することはまず無い。",
          artist: "Jason Chan",
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
          supertypes: [],
          types: [
            { name: 'ソーサリー' },
          ],
          subtypes: [],
          text: "対戦相手１人がコントロールするクリーチャー１体を対象とする。それは自身のパワーに等しい点数のダメージを、そのプレイヤーがコントロールする他の各クリーチャーにそれぞれ与える。その後、それらの各クリーチャーは、それぞれのパワーに等しい点数のダメージをそのクリーチャーに与える。",
          oracle: "Target creature an opponent controls deals damage equal to its power to each other creature that player controls, then each of those creatures deals damage equal to its power to that creature.",
          flavor_text: "頭目であることは、満月のたびにそれを証明しなければいけないことだ。",
          artist: "Randy Gallegos",
        },
      ]
      assert_equal(expect, WisdomGuild.get('DKA082'))

      expect = [
        {
          name: "祖先の幻視",
          english_name: "Ancestral Vision",
          furigana: "そせんのげんし",
          mana_cost: "",
          colors: [
            { name: '青' },
          ],
          supertypes: [],
          types: [
            { name: 'ソーサリー' },
          ],
          subtypes: [],
          text: "待機４ ― (青)（このカードをあなたの手札から唱えるのではなく、(青)を支払うとともにそれを時間(time)カウンターが４個置かれた状態で追放する。あなたのアップキープの開始時に、時間カウンターを１個取り除く。最後の１個を取り除いたとき、それをそのマナ・コストを支払うことなく唱える。）\nプレイヤー１人を対象とする。そのプレイヤーはカードを３枚引く。",
          oracle: "Suspend 4 --- {U} （Rather than cast this card from your hand, pay {U} and exile it with four time counters on it. At the beginning of your upkeep, remove a time counter. When the last is removed, cast it without paying its mana cost.）\nTarget player draws three cards.",
          flavor_text: "",
          artist: "John Avon",
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
          supertypes: [],
          types: [
            { name: 'エンチャント' },
          ],
          subtypes: [
            { name: 'オーラ', english_name: 'Aura' },
          ],
          text: "エンチャント（クリーチャー）\nエンチャントされているクリーチャーは攻撃もブロックもできず、その起動型能力を起動できない。",
          oracle: "Enchant creature\nEnchanted creature can't attack or block, and its activated abilities can't be activated.",
          flavor_text: "「あんたの罪なら立証してやるわ。うちらが無実の者を拘引するわけないでしょ。」――― 第10管区の拘引者、ラヴィニア.",
          artist: "Greg Staples",
        },
      ]
      assert_equal(expect, WisdomGuild.get('RTR003'))

      expect = [
        {
          name: '不思議のバザール',
          english_name: 'Bazaar of Wonders',
          furigana: 'ふしぎのばざーる',
          mana_cost: '(３)(青)(青)',
          supertypes: [
            { name: 'ワールド' },
          ],
          types: [
            { name: 'エンチャント' },
          ],
          subtypes: [],
          text: "不思議のバザールが戦場に出たとき、すべての墓地にあるすべてのカードを追放する。\nプレイヤーが呪文を唱えるたび、それと同じ名前を持つカードがいずれかの墓地にあるか同じ名前を持つトークンでないパーマネントが戦場にある場合、それを打ち消す。",
          oracle: "When Bazaar of Wonders enters the battlefield, exile all cards from all graveyards.\nWhenever a player casts a spell, counter it if a card with the same name is in a graveyard or a nontoken permanent with the same name is on the battlefield.",
          flavor_text: "",
          artist: "Liz Danforth",
        },
      ]
      assert_equal(expect, WisdomGuild.get('MIR055'))
    end

    test 'Artifact' do
      expect = [
        {
          name: 'アクローマの記念碑',
          english_name: "Akroma's Memorial",
          furigana: 'あくろーまのきねんひ',
          mana_cost: '(７)',
          supertypes: [
            { name: '伝説の' },
          ],
          types: [
            { name: 'アーティファクト' },
          ],
          subtypes: [],
          text: "あなたがコントロールするクリーチャーは飛行、先制攻撃、警戒、トランプル、速攻、プロテクション（黒）とプロテクション（赤）を持つ。",
          oracle: "Creatures you control have flying, first strike, vigilance, trample, haste, and protection from black and from red.",
          flavor_text: "「休息も慈悲も与えぬ。何があってもだ。」 ――― 碑文",
          artist: "Dan Scott",
        },
      ]
      assert_equal(expect, WisdomGuild.get('M13200'))

      expect = [
        {
          name: '金属製の巨像',
          english_name: "Metalwork Colossus",
          furigana: 'きんぞくせいのきょぞう',
          mana_cost: '(１１)',
          supertypes: [],
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
          artist: "Jaime Jones",
        },
      ]
      assert_equal(expect, WisdomGuild.get('KLD222'))

      expect = [
        {
          name: '領事の旗艦、スカイソブリン',
          english_name: "Skysovereign, Consul Flagship",
          furigana: 'りょうじのきかんすかいそぶりん',
          mana_cost: '(５)',
          supertypes: [
            { name: '伝説の' },
          ],
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
          artist: "Jung Park",
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
          supertypes: [
            { name: '伝説の' },
          ],
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
          artist: "Aleksi Briclot",
        },
      ]
      assert_equal(expect, WisdomGuild.get('M11058'))

      expect = [
        {
          name: '自然に仕える者、ニッサ',
          english_name: "Nissa, Steward of Elements",
          furigana: 'しぜんにつかえるものにっさ',
          mana_cost: '(Ｘ)(緑)(青)',
          supertypes: [
            { name: '伝説の' },
          ],
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
          artist: "Howard Lyon",
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
          supertypes: [
            { name: '基本' },
          ],
          types: [
            { name: '土地' },
          ],
          subtypes: [
            { name: '平地', english_name: 'Plains' },
          ],
          text: "(白)",
          oracle: "W",
          flavor_text: "",
          artist: "Dimitar",
        },
      ]
      assert_equal(expect, WisdomGuild.get('RIX192'))

      expect = [
        {
          name: '荒地',
          english_name: "Wastes",
          furigana: 'あれち',
          mana_cost: '',
          supertypes: [
            { name: '基本' },
          ],
          types: [
            { name: '土地' },
          ],
          subtypes: [],
          text: "(Ｔ)：あなたのマナ・プールに(◇)を加える。",
          oracle: "{T}: Add {C} to your mana pool.",
          flavor_text: "",
          artist: "Jason Felix",
        },
      ]
      assert_equal(expect, WisdomGuild.get('OGW183'))

      expect = [
        {
          name: '蒸気孔',
          english_name: "Steam Vents",
          furigana: 'じょうきこう',
          mana_cost: '',
          supertypes: [],
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
          artist: "Yeong-Hao Han",
        },
      ]
      assert_equal(expect, WisdomGuild.get('RTR247'))

      expect = [
        {
          name: 'ドライアドの東屋',
          english_name: "Dryad Arbor",
          furigana: 'どらいあどのあずまや',
          mana_cost: '',
          colors: [
            { name: '緑' },
          ],
          supertypes: [],
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
          artist: "Eric Fortune",
        },
      ]
      assert_equal(expect, WisdomGuild.get('FUT174'))

      expect = [
        {
          name: '暗黒の深部',
          english_name: "Dark Depths",
          furigana: 'あんこくのしんぶ',
          mana_cost: '',
          supertypes: [
            { name: '伝説の' },
            { name: '氷雪' },
          ],
          types: [
            { name: '土地' },
          ],
          subtypes: [],
          text: "暗黒の深部はその上に氷(ice)カウンターが１０個置かれた状態で戦場に出る。\n(３)：暗黒の深部から氷カウンターを１個取り除く。\n暗黒の深部の上に氷カウンターが１個も置かれていないとき、それを生け贄に捧げる。そうした場合、飛行と破壊不能を持つ《マリット・レイジ/Marit Lage》という名前の黒の20/20の伝説のアバター(Avatar)・クリーチャー・トークンを１体生成する。",
          oracle: "Dark Depths enters the battlefield with ten ice counters on it.\n{3}: Remove an ice counter from Dark Depths.\nWhen Dark Depths has no ice counters on it, sacrifice it. If you do, create a legendary 20/20 black Avatar creature token with flying and indestructible named Marit Lage.",
          flavor_text: "",
          artist: "Stephan Martiniere",
        },
      ]
      assert_equal(expect, WisdomGuild.get('CSP145'))

      expect = [
        {
          name: '冠雪の平地',
          english_name: "Snow-Covered Plains",
          furigana: 'かんせつのへいち',
          mana_cost: '',
          supertypes: [
            { name: '基本' },
            { name: '氷雪' },
          ],
          types: [
            { name: '土地' },
          ],
          subtypes: [
            { name: '平地', english_name: 'Plains' },
          ],
          text: "(白)",
          oracle: "W",
          flavor_text: "",
          artist: "Mark Romanoski",
        },
      ]
      assert_equal(expect, WisdomGuild.get('CSP151'))
    end

    test 'split' do
      expect = [
        {
          name: '火',
          english_name: "Fire",
          furigana: 'ひ',
          mana_cost: '(１)(赤)',
          supertypes: [],
          types: [
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "１つか２つのクリーチャーとプレイヤーの組み合わせを対象とする。火は、それらに２点のダメージを望むように割り振って与える。",
          oracle: "Fire deals 2 damage divided as you choose among one or two target creatures and/or players.",
          flavor_text: "",
          artist: "David Martin",
        },
        {
          name: '氷',
          english_name: "Ice",
          furigana: 'こおり',
          mana_cost: '(１)(青)',
          supertypes: [],
          types: [
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "パーマネント１つを対象とし、それをタップする。\nカードを１枚引く。",
          oracle: "Tap target permanent.\nDraw a card.",
          flavor_text: "",
          artist: "Franz Vohwinkel",
        },
      ]
      assert_equal(expect, WisdomGuild.get('APC128'))

      expect = [
        {
          name: '摩耗',
          english_name: "Wear",
          furigana: 'まもう',
          mana_cost: '(１)(赤)',
          supertypes: [],
          types: [
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "アーティファクト１つを対象とし、それを破壊する。\n融合（あなたはこのカードの片方の半分または両方の半分をあなたの手札から唱えてもよい。）",
          oracle: "Destroy target artifact.\nFuse （You may cast one or both halves of this card from your hand.）",
          flavor_text: "",
          artist: "Ryan Pancoast",
        },
        {
          name: '損耗',
          english_name: "Tear",
          furigana: 'そんもう',
          mana_cost: '(白)',
          supertypes: [],
          types: [
            { name: 'インスタント' },
          ],
          subtypes: [],
          text: "エンチャント１つを対象とし、それを破壊する。\n融合（あなたはこのカードの片方の半分または両方の半分をあなたの手札から唱えてもよい。）",
          oracle: "Destroy target enchantment.\nFuse （You may cast one or both halves of this card from your hand.）",
          flavor_text: "",
          artist: "Ryan Pancoast",
        },
      ]
      assert_equal(expect, WisdomGuild.get('DGM135'))

      expect = [
        {
          name: '木端',
          english_name: "Cut",
          furigana: 'こっぱ',
          mana_cost: '(１)(赤)',
          supertypes: [],
          types: [
            { name: 'ソーサリー' },
          ],
          subtypes: [],
          text: "クリーチャー１体を対象とする。木端はそれに４点のダメージを与える。",
          oracle: "Cut deals 4 damage to target creature.",
          flavor_text: "",
          artist: "Raymond Swanland",
        },
        {
          name: '微塵',
          english_name: "Ribbons",
          furigana: 'みじん',
          mana_cost: '(Ｘ)(黒)(黒)',
          supertypes: [],
          types: [
            { name: 'ソーサリー' },
          ],
          subtypes: [],
          text: "余波（この呪文はあなたの墓地からのみ唱えられる。その後、これを追放する。）\n各対戦相手はそれぞれＸ点のライフを失う。",
          oracle: "Aftermath （Cast this spell only from your graveyard. Then exile it.）\nEach opponent loses X life.",
          flavor_text: "",
          artist: "Raymond Swanland",
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
          supertypes: [],
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
          artist: "James Ryman",
        },
      ]
      assert_equal(expect, WisdomGuild.get('ROE112'))
    end

    test 'flip' do
      expect = [
        {
          name: '呪師の弟子',
          english_name: "Jushi Apprentice",
          furigana: 'じゅしのでし',
          mana_cost: '(１)(青)',
          supertypes: [],
          types: [
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: '人間', english_name: 'Human' },
            { name: 'ウィザード', english_name: 'Wizard' },
          ],
          text: "(２)(青),(Ｔ)：カードを１枚引く。あなたの手札にカードが９枚以上ある場合、呪師の弟子を反転する。",
          oracle: "{2}{U}, {T}: Draw a card. If you have nine or more cards in hand, flip Jushi Apprentice.",
          size: '1/2',
          power: 1,
          toughness: 2,
          flavor_text: "",
          artist: "Glen Angus",
        },
        {
          name: '暴く者、智也',
          english_name: "Tomoya the Revealer",
          furigana: 'あばくものともや',
          mana_cost: '(１)(青)',
          supertypes: [
            { name: '伝説の' },
          ],
          types: [
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: '人間', english_name: 'Human' },
            { name: 'ウィザード', english_name: 'Wizard' },
          ],
          text: "(３)(青)(青),(Ｔ)：プレイヤー１人を対象とする。そのプレイヤーはカードをＸ枚引く。Ｘはあなたの手札のカードの枚数に等しい。",
          oracle: "{3}{U}{U}, {T}: Target player draws X cards, where X is the number of cards in your hand.",
          size: '2/3',
          power: 2,
          toughness: 3,
          flavor_text: "",
          artist: "Glen Angus",
        },
      ]
      assert_equal(expect, WisdomGuild.get('CHK070'))

      expect = [
        {
          name: '上位の空民、エラヨウ',
          english_name: "Erayo, Soratami Ascendant",
          furigana: 'じょういのそらたみえらよう',
          mana_cost: '(１)(青)',
          supertypes: [
            { name: '伝説の' },
          ],
          types: [
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: 'ムーンフォーク', english_name: 'Moonfolk' },
            { name: 'モンク', english_name: 'Monk' },
          ],
          text: "飛行\nいずれかのターンに４つ目の呪文が唱えられるたび、上位の空民、エラヨウを反転する。",
          oracle: "Flying\nWhenever the fourth spell of a turn is cast, flip Erayo, Soratami Ascendant.",
          size: '1/1',
          power: 1,
          toughness: 1,
          flavor_text: "",
          artist: "Matt Cavotta",
        },
        {
          name: 'エラヨウの本質',
          english_name: "Erayo's Essence",
          furigana: 'えらようのほんしつ',
          mana_cost: '(１)(青)',
          supertypes: [
            { name: '伝説の' },
          ],
          types: [
            { name: 'エンチャント' },
          ],
          subtypes: [],
          text: "対戦相手１人が各ターンの最初の呪文を唱えるたび、その呪文を打ち消す。",
          oracle: "Whenever an opponent casts his or her first spell each turn, counter that spell.",
          flavor_text: "",
          artist: "Matt Cavotta",
        },
      ]
      assert_equal(expect, WisdomGuild.get('SOK035'))
    end

    test 'double_faced' do
      expect = [
        {
          name: '秘密を掘り下げる者',
          english_name: "Delver of Secrets",
          furigana: 'ひみつをほりさげるもの',
          mana_cost: '(青)',
          supertypes: [],
          types: [
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: '人間', english_name: 'Human' },
            { name: 'ウィザード', english_name: 'Wizard' },
          ],
          text: "あなたのアップキープの開始時に、あなたのライブラリーの一番上のカードを見る。あなたはそのカードを公開してもよい。これによりインスタント・カードかソーサリー・カードが公開された場合、秘密を掘り下げる者を変身させる。",
          oracle: "At the beginning of your upkeep, look at the top card of your library. You may reveal that card. If an instant or sorcery card is revealed this way, transform Delver of Secrets.",
          size: '1/1',
          power: 1,
          toughness: 1,
          flavor_text: "",
          artist: "Nils Hamm",
        },
        {
          name: '昆虫の逸脱者',
          english_name: "Insectile Aberration",
          furigana: 'こんちゅうのいつだつしゃ',
          mana_cost: '',
          colors: [
            { name: '青' },
          ],
          supertypes: [],
          types: [
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: '人間', english_name: 'Human' },
            { name: '昆虫', english_name: 'Insect' },
          ],
          text: "飛行",
          oracle: "Flying",
          size: '3/2',
          power: 3,
          toughness: 2,
          flavor_text: "",
          artist: "Nils Hamm",
        },
      ]
      assert_equal(expect, WisdomGuild.get('ISD051'))

      expect = [
        {
          name: 'ヴリンの神童、ジェイス',
          english_name: "Jace, Vryn's Prodigy",
          furigana: 'う゛りんのしんどうじぇいす',
          mana_cost: '(１)(青)',
          supertypes: [
            { name: '伝説の' },
          ],
          types: [
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: '人間', english_name: 'Human' },
            { name: 'ウィザード', english_name: 'Wizard' },
          ],
          text: "(Ｔ)：カードを１枚引き、その後カードを１枚捨てる。あなたの墓地にカードが５枚以上あるなら、ヴリンの神童、ジェイスを追放し、その後、これを変身させた状態でオーナーのコントロール下で戦場に戻す。",
          oracle: "{T}: Draw a card, then discard a card. If there are five or more cards in your graveyard, exile Jace, Vryn's Prodigy, then return him to the battlefield transformed under his owner's control.",
          size: '0/2',
          power: 0,
          toughness: 2,
          flavor_text: "",
          artist: "Jaime Jones",
        },
        {
          name: '束縛なきテレパス、ジェイス',
          english_name: "Jace, Telepath Unbound",
          furigana: 'そくばくなきてれぱすじぇいす',
          mana_cost: '',
          colors: [
            { name: '青' },
          ],
          supertypes: [
            { name: '伝説の' },
          ],
          types: [
            { name: 'プレインズウォーカー' },
          ],
          subtypes: [
            { name: 'ジェイス', english_name: 'Jace' },
          ],
          text: "[+1]：クリーチャーを最大１体まで対象とする。あなたの次のターンまで、それは-2/-0の修整を受ける。\n[-3]：あなたの墓地にある、インスタント・カード１枚かソーサリー・カード１枚を対象とする。このターン、あなたはそれを唱えてもよい。このターンにそのカードがあなたの墓地に置かれるなら、代わりにそれを追放する。\n[-9]：あなたは「あなたが呪文を１つ唱えるたび、対戦相手１人を対象とする。そのプレイヤーは自分のライブラリーの一番上から５枚のカードを自分の墓地に置く。」を持つ紋章を得る。",
          oracle: "+1: Up to one target creature gets -2/-0 until your next turn.\n-3: You may cast target instant or sorcery card from your graveyard this turn. If that card would be put into your graveyard this turn, exile it instead.\n-9: You get an emblem with \"Whenever you cast a spell, target opponent puts the top five cards of his or her library into his or her graveyard.\"",
          size: '5',
          loyalty: 5,
          flavor_text: "",
          artist: "Jaime Jones",
        },
      ]
      assert_equal(expect, WisdomGuild.get('ORI060'))

      expect = [
        {
          name: '驚恐の目覚め',
          english_name: "Startled Awake",
          furigana: 'きょうきょうのめざめ',
          mana_cost: '(２)(青)(青)',
          supertypes: [],
          types: [
            { name: 'ソーサリー' },
          ],
          subtypes: [],
          text: "対戦相手１人を対象とする。そのプレイヤーは、自分のライブラリーの一番上から１３枚のカードを自分の墓地に置く。\n(３)(青)(青)：あなたの墓地から驚恐の目覚めを変身させた状態で戦場に出す。この能力は、あなたがソーサリーを唱えられるときにのみ起動できる。",
          oracle: "Target opponent puts the top thirteen cards of his or her library into his or her graveyard.\n{3}{U}{U}: Put Startled Awake from your graveyard onto the battlefield transformed. Activate this ability only any time you could cast a sorcery.",
          flavor_text: "",
          artist: "Sean Sevestre",
        },
        {
          name: '絶え間ない悪夢',
          english_name: "Persistent Nightmare",
          furigana: 'たえまないあくむ',
          mana_cost: '',
          colors: [
            { name: '青' },
          ],
          supertypes: [],
          types: [
            { name: 'クリーチャー' },
          ],
          subtypes: [
            { name: 'ナイトメア', english_name: 'Nightmare' },
          ],
          text: "潜伏（このクリーチャーは、これより大きなパワーを持つクリーチャーによってはブロックされない。）\n絶え間ない悪夢がプレイヤー１人に戦闘ダメージを与えたとき、これをオーナーの手札に戻す。",
          oracle: "Skulk （This creature can't be blocked by creatures with greater power.）\nWhen Persistent Nightmare deals combat damage to a player, return it to its owner's hand.",
          size: '1/1',
          power: 1,
          toughness: 1,
          flavor_text: "",
          artist: "Sean Sevestre",
        },
      ]
      assert_equal(expect, WisdomGuild.get('SOI088'))

      expect = [
        {
          name: 'イトリモクの成長儀式',
          english_name: "Growing Rites of Itlimoc",
          furigana: 'いとりもくのせいちょうぎしき',
          mana_cost: '(２)(緑)',
          supertypes: [
            { name: '伝説の' },
          ],
          types: [
            { name: 'エンチャント' },
          ],
          subtypes: [],
          text: "イトリモクの成長儀式が戦場に出たとき、あなたのライブラリーの一番上からカードを４枚見る。あなたはその中からクリーチャー・カード１枚を公開してあなたの手札に加えてもよい。残りをあなたのライブラリーの一番下に望む順番で置く。\nあなたの終了ステップの開始時に、あなたがクリーチャーを４体以上コントロールしている場合、イトリモクの成長儀式を変身させる。",
          oracle: "When Growing Rites of Itlimoc enters the battlefield, look at the top four cards of your library. You may reveal a creature card from among them and put it into your hand. Put the rest on the bottom of your library in any order.\nAt the beginning of your end step, if you control four or more creatures, transform Growing Rites of Itlimoc.",
          flavor_text: "",
          artist: "Grzegorz Rutkowski",
        },
        {
          name: '太陽の揺籃の地、イトリモク',
          english_name: "Itlimoc, Cradle of the Sun",
          furigana: 'たいようのようらんのちいとりもく',
          mana_cost: '',
          supertypes: [
            { name: '伝説の' },
          ],
          types: [
            { name: '土地' },
          ],
          subtypes: [],
          text: "（《イトリモクの成長儀式/Growing Rites of Itlimoc》から変身する。）\n(Ｔ)：あなたのマナ・プールに(緑)を加える。\n(Ｔ)：あなたのマナ・プールに、あなたがコントロールしているクリーチャー１体につき(緑)を加える。",
          oracle: "（Transforms from Growing Rites of Itlimoc.）\n{T}: Add {G} to your mana pool.\n{T}: Add {G} to your mana pool for each creature you control.",
          flavor_text: "",
          artist: "Grzegorz Rutkowski",
        },
      ]
      assert_equal(expect, WisdomGuild.get('XLN191'))

      expect = [
        {
          name: 'アーリン・コード',
          english_name: "Arlinn Kord",
          furigana: 'あーりんこーど',
          mana_cost: '(２)(赤)(緑)',
          supertypes: [
            { name: '伝説の' },
          ],
          types: [
            { name: 'プレインズウォーカー' },
          ],
          subtypes: [
            { name: 'アーリン', english_name: 'Arlinn' },
          ],
          text: "[+1]：クリーチャーを最大１体まで対象とする。ターン終了時まで、それは+2/+2の修整を受けるとともに警戒と速攻を得る。\n[0]：緑の2/2の狼(Wolf)クリーチャー・トークンを１体生成する。アーリン・コードを変身させる。",
          oracle: "+1: Until end of turn, up to one target creature gets +2/+2 and gains vigilance and haste.\n0: Create a 2/2 green Wolf creature token. Transform Arlinn Kord.",
          size: '3',
          loyalty: 3,
          flavor_text: "",
          artist: "Winona Nelson",
        },
        {
          name: '月の抱擁、アーリン',
          english_name: "Arlinn, Embraced by the Moon",
          furigana: 'つきのほうようあーりん',
          mana_cost: '',
          colors: [
            { name: '赤' },
            { name: '緑' },
          ],
          supertypes: [
            { name: '伝説の' },
          ],
          types: [
            { name: 'プレインズウォーカー' },
          ],
          subtypes: [
            { name: 'アーリン', english_name: 'Arlinn' },
          ],
          text: "[+1]：ターン終了時まで、あなたがコントロールするクリーチャーは+1/+1の修整を受けるとともにトランプルを得る。\n[-1]：クリーチャー１体かプレイヤー１人を対象とする。月の抱擁、アーリンはそれに３点のダメージを与える。月の抱擁、アーリンを変身させる。\n[-6]：あなたは「あなたがコントロールするクリーチャーは、速攻と『(Ｔ)：クリーチャー１体かプレイヤー１人を対象とする。このクリーチャーはそれに自身のパワーに等しい点数のダメージを与える。』を持つ。」を持つ紋章を得る。",
          oracle: "+1: Creatures you control get +1/+1 and gain trample until end of turn.\n-1: Arlinn, Embraced by the Moon deals 3 damage to target creature or player. Transform Arlinn, Embraced by the Moon.\n-6: You get an emblem with \"Creatures you control have haste and ‘{T}: This creature deals damage equal to its power to target creature or player.'\"",
          flavor_text: "",
          artist: "Winona Nelson",
        },
      ]
      assert_equal(expect, WisdomGuild.get('SOI243'))
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
