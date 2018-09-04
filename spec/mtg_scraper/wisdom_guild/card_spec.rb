RSpec.describe MtgScraper::WisdomGuild::Card do

  let(:page){ page = MtgScraper::Page.new(url) }
  let(:html){ page.html }
  let(:card){ MtgScraper::WisdomGuild::Card.new(html) }

  describe '#to_hash' do

    let(:url){ 'http://whisper.wisdom-guild.net/card/UDS065/' }
    it do
      expect(card.to_hash).to eq(
        name: "ファイレクシアの抹殺者",
        english_name: "Phyrexian Negator",
        multiverseid: 207891,
        details: [
          {
            name: 'ファイレクシアの抹殺者',
            english_name: 'Phyrexian Negator',
            furigana: 'ふぁいれくしあのまっさつしゃ',
            mana_cost: '(２)(黒)',
            supertypes: [],
            types: [
              { name: 'クリーチャー' },
            ],
            subtypes: [
              { name: 'ホラー', english_name: 'Horror' },
            ],
            text: "トランプル\nファイレクシアの抹殺者にダメージが与えられるたび、その点数と同じ数のパーマネントを生け贄に捧げる。",
            oracle: "Trample\nWhenever Phyrexian Negator is dealt damage, sacrifice that many permanents.",
            power: "5",
            toughness: "5",
            flavor_text: "彼らは終わらせるために存在しているんだ。",
            artists: [
              { english_name: "John Zeleznik" },
            ],
          },
        ],
      )
    end

    describe 'attributes' do

      it do
        expect(card.error?).to eq(false)
        expect(card.name).to eq('ファイレクシアの抹殺者')
        expect(card.english_name).to eq('Phyrexian Negator')
        expect(card.multiverseid).to eq(207891)
      end

    end

  end

  describe '#details' do

    context 'Creature' do

      context 'normal' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/10E039/' }
        it do
          expect(card.details.length).to eq(1)
          expect(card.details.first.to_hash).to eq({
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
            text: "飛行、警戒",
            oracle: "Flying, vigilance",
            power: "4",
            toughness: "4",
            flavor_text: "彼女の剣はどんな聖歌隊よりも美しく歌う。",
            artists: [
              { english_name: "Greg Staples" },
            ],
          })
        end
      end

      context 'legendary' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/AVR106/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('グリセルブランド')
          expect(detail.supertypes).to eq([
            { name: '伝説の' },
          ])
        end
      end

      context '* power toughness' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/FUT153/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('タルモゴイフ')
          expect(detail.power).to eq('*')
          expect(detail.toughness).to eq('1+*')
        end
      end

      context 'multiple subtypes' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/M11003/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('アジャニの群れ仲間')
          expect(detail.subtypes).to eq([
            { name: '猫', english_name: 'Cat' },
            { name: '兵士', english_name: 'Soldier' },
          ])
        end
      end

      context 'multiple subtypes (lack japanese name)' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/SOI207/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('墓モグラ')
          expect(detail.subtypes).to eq([
            { name: '', english_name: 'Mole' },
            { name: 'ビースト', english_name: 'Beast' },
          ])
        end
      end

      context 'levelup' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/ROE112/' }
        it do
          expect(card.details.length).to eq(1)
          expect(card.details.first.to_hash).to eq({
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
            power: "1",
            toughness: "1",
            flavor_text: "",
            artists: [
              { english_name: "James Ryman" },
            ],
          })
        end
      end

      context 'flip' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/CHK070/' }
        it do
          expect(card.details.length).to eq(2)
          expect(card.details[0].to_hash).to eq({
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
            power: "1",
            toughness: "2",
            flavor_text: "",
            artists: [
              { english_name: "Glen Angus" },
            ],
          })
          expect(card.details[1].to_hash).to eq({
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
            power: "2",
            toughness: "3",
            flavor_text: "",
            artists: [
              { english_name: "Glen Angus" },
            ],
          })
        end
      end

      context 'flip (enchantment)' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/SOK035/' }
        it do
          expect(card.details.length).to eq(2)
          expect(card.details[0].to_hash).to eq({
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
            power: "1",
            toughness: "1",
            flavor_text: "",
            artists: [
              { english_name: "Matt Cavotta" },
            ],
          })
          expect(card.details[1].to_hash).to eq({
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
            artists: [
              { english_name: "Matt Cavotta" },
            ],
          })
        end
      end

      context 'double_faced' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/ISD051/' }
        it do
          expect(card.details.length).to eq(2)
          expect(card.details[0].to_hash).to eq({
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
            power: "1",
            toughness: "1",
            flavor_text: "",
            artists: [
              { english_name: "Nils Hamm" },
            ],
          })
          expect(card.details[1].to_hash).to eq({
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
            power: "3",
            toughness: "2",
            flavor_text: "",
            artists: [
              { english_name: "Nils Hamm" },
            ],
          })
        end
      end

      context 'double_faced (planeswalker)' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/ORI060/' }
        it do
          expect(card.details.length).to eq(2)
          expect(card.details[0].to_hash).to eq({
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
            power: "0",
            toughness: "2",
            flavor_text: "",
            artists: [
              { english_name: "Jaime Jones" },
            ],
          })
          expect(card.details[1].to_hash).to eq({
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
            loyalty: "5",
            flavor_text: "",
            artists: [
              { english_name: "Jaime Jones" },
            ],
          })
        end

      end

    end

    describe 'Instant' do

      context 'normal' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/ALA033/' }
        it do
          expect(card.details.length).to eq(1)
          expect(card.details.first.to_hash).to eq({
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
            artists: [
              { english_name: "David Palumbo" },
            ],
          })
        end
      end

      context '0 mana' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/FUT042/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('否定の契約')
          expect(detail.colors).to eq([
            { name: '青' },
          ])
        end
      end

      context 'tribal' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/LRW194/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('タール火')
          expect(detail.types).to eq([
            { name: '部族' },
            { name: 'インスタント' },
          ])
          expect(detail.subtypes).to eq([
            { name: 'ゴブリン', english_name: 'Goblin' }
          ])
        end
      end

    end

    describe 'Sorcery' do

      context 'normal' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/THS107/' }
        it do
          expect(card.details.length).to eq(1)
          expect(card.details.first.to_hash).to eq({
            name: '思考囲い',
            english_name: 'Thoughtseize',
            furigana: 'しこうがこい',
            mana_cost: '(黒)',
            supertypes: [],
            types: [
              { name: 'ソーサリー' },
            ],
            subtypes: [],
            text: "プレイヤー１人を対象とする。そのプレイヤーは手札を公開する。あなたはその中から土地でないカードを１枚選ぶ。そのプレイヤーはそのカードを捨てる。あなたは２点のライフを失う。",
            oracle: "Target player reveals their hand. You choose a nonland card from it. That player discards that card. You lose 2 life.",
            flavor_text: "「知識とは時に重荷となる。解放せよ。お主の恐怖を残らず私に解き放つのだ。」 ――― 悪夢の織り手、アショク.",
            artists: [
              { english_name: "Lucas Graciano" },
            ],
          })
        end
      end

      context '0 mana' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/TSP048/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('祖先の幻視')
          expect(detail.colors).to eq([
            { name: '青' },
          ])
        end
      end

      context 'tribal' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/ROE001/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('全ては塵')
          expect(detail.types).to eq([
            { name: '部族' },
            { name: 'ソーサリー' },
          ])
          expect(detail.subtypes).to eq([
            { name: 'エルドラージ', english_name: 'Eldrazi' }
          ])
        end
      end

      context 'maltiple artists' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/M10128/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('燃え立つ調査')
          expect(detail.artists).to eq([
            { english_name: "Zoltan Boros" },
            { english_name: "Gabor Szikszai" },
          ])
        end
      end

      context 'double_faced' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/SOI088/' }
        it do
          expect(card.details.length).to eq(2)
          expect(card.details[0].to_hash).to eq({
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
            artists: [
              { english_name: "Sean Sevestre" },
            ],
          })
          expect(card.details[1].to_hash).to eq({
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
            power: "1",
            toughness: "1",
            flavor_text: "",
            artists: [
              { english_name: "Sean Sevestre" },
            ],
          })
        end
      end

    end

    describe 'Enchantment' do

      context 'normal' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/ULG110/' }
        it do
          expect(card.details.length).to eq(1)
          expect(card.details.first.to_hash).to eq({
            name: '怨恨',
            english_name: 'Rancor',
            furigana: 'えんこん',
            mana_cost: '(緑)',
            supertypes: [],
            types: [
              { name: 'エンチャント' },
            ],
            subtypes: [
              { name:'オーラ', english_name: 'Aura' },
            ],
            text: "エンチャント（クリーチャー）\nエンチャントされているクリーチャーは、+2/+0の修整を受けるとともにトランプルを持つ。\n怨恨が戦場からいずれかの墓地に置かれたとき、怨恨をオーナーの手札に戻す。",
            oracle: "Enchant creature\nEnchanted creature gets +2/+0 and has trample.\nWhen Rancor is put into a graveyard from the battlefield, return Rancor to its owner's hand.",
            flavor_text: "憎しみは、憎むべき者が死んだ後まで残る。",
            artists: [
              { english_name: "Kev Walker" },
            ],
          })
        end
      end

      context 'world' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/MIR055/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('不思議のバザール')
          expect(detail.supertypes).to eq([
            { name: 'ワールド' },
          ])
        end
      end

      context 'tribal' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/MOR058/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('苦花')
          expect(detail.types).to eq([
            { name: '部族' },
            { name: 'エンチャント' },
          ])
          expect(detail.subtypes).to eq([
            { name: 'フェアリー', english_name: 'Faerie' }
          ])
        end
      end

      context 'double_faced' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/XLN191/' }
        it do
          expect(card.details.length).to eq(2)
          expect(card.details[0].to_hash).to eq({
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
            artists: [
              { english_name: "Grzegorz Rutkowski" },
            ],
          })
          expect(card.details[1].to_hash).to eq({
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
            artists: [
              { english_name: "Grzegorz Rutkowski" },
            ],
          })
        end
      end

    end

    describe 'Artifact' do

      context 'normal' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/LRW261/' }
        it do
          expect(card.details.length).to eq(1)
          expect(card.details.first.to_hash).to eq({
            name: 'バネ葉の太鼓',
            english_name: 'Springleaf Drum',
            furigana: 'ばねはのたいこ',
            mana_cost: '(１)',
            supertypes: [],
            types: [
              { name: 'アーティファクト' },
            ],
            subtypes: [],
            text: "(Ｔ),あなたがコントロールするアンタップ状態のクリーチャーを１体タップする：好きな色１色のマナ１点を加える。",
            oracle: "{T}, Tap an untapped creature you control: Add one mana of any color.",
            flavor_text: "午後をかけてトビハゼを試してみた結果、スクラッチにはカワゴイの方がいい騒音を立ててくれるのがわかった。",
            artists: [
              { english_name: "Cyril Van Der Haegen" },
            ],
          })
        end
      end

      context 'creature' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/KLD222/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('金属製の巨像')
          expect(detail.types).to eq([
            { name: 'アーティファクト' },
            { name: 'クリーチャー' },
          ])
          expect(detail.subtypes).to eq([
            { name: '構築物', english_name: 'Construct' },
          ])
        end
      end

      context 'vehicle' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/KLD234/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('領事の旗艦、スカイソブリン')
          expect(detail.supertypes).to eq([
            { name: '伝説の' },
          ])
          expect(detail.types).to eq([
            { name: 'アーティファクト' },
          ])
          expect(detail.subtypes).to eq([
            { name: '機体', english_name: 'Vehicle' },
          ])
        end
      end

      context 'equipment' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/MOR144/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('黒曜石の戦斧')
          expect(detail.types).to eq([
            { name: '部族' },
            { name: 'アーティファクト' },
          ])
          expect(detail.subtypes).to eq([
            { name: '戦士', english_name: 'Warrior' },
            { name: '装備品', english_name: 'Equipment' },
          ])
        end
      end

      context 'double_faced' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/DKA147/' }
        it do
          expect(card.details.length).to eq(2)
          expect(card.details[0].to_hash).to eq({
            name: '束縛の刃、エルブラス',
            english_name: "Elbrus, the Binding Blade",
            furigana: 'そくばくのやいばえるぶらす',
            mana_cost: '(７)',
            supertypes: [
              { name: '伝説の' },
            ],
            types: [
              { name: 'アーティファクト' },
            ],
            subtypes: [
              { name: '装備品', english_name: 'Equipment' },
            ],
            text: "装備しているクリーチャーは+1/+0の修整を受ける。\n装備しているクリーチャーがプレイヤー１人に戦闘ダメージを与えたとき、束縛の刃、エルブラスをはずし、その後それを変身させる。\n装備(１)",
            oracle: "Equipped creature gets +1/+0.\nWhen equipped creature deals combat damage to a player, unattach Elbrus, the Binding Blade, then transform it.\nEquip {1}",
            flavor_text: "",
            artists: [
              { english_name: "Eric Deschamps" },
            ],
          })
          expect(card.details[1].to_hash).to eq({
            name: '解き放たれたウィゼンガー',
            english_name: "Withengar Unbound",
            furigana: 'ときはなたれたうぃぜんがー',
            mana_cost: '',
            colors: [
              { name: '黒' },
            ],
            supertypes: [
              { name: '伝説の' },
            ],
            types: [
              { name: 'クリーチャー' },
            ],
            subtypes: [
              { name: 'デーモン', english_name: 'Demon' },
            ],
            text: "飛行、威嚇、トランプル（威嚇を持つクリーチャーはアーティファクト・クリーチャーかこれと共通の色を持つクリーチャー以外にはブロックされない。）\nプレイヤー１人がゲームに敗北するたび、解き放たれたウィゼンガーの上に+1/+1カウンターを１３個置く。",
            oracle: "Flying, intimidate, trample （A creature with intimidate can't be blocked except by artifact creatures and/or creatures that share a color with it.）\nWhenever a player loses the game, put thirteen +1/+1 counters on Withengar Unbound.",
            power: "13",
            toughness: "13",
            flavor_text: "",
            artists: [
              { english_name: "Eric Deschamps" },
            ],
          })
        end
      end
    end

    describe 'Planeswalker' do

      context 'normal' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/M11058/' }
        it do
          expect(card.details.length).to eq(1)
          expect(card.details.first.to_hash).to eq({
            name: 'ジェイス・ベレレン',
            english_name: 'Jace Beleren',
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
            loyalty: "3",
            flavor_text: "",
            artists: [
              { english_name: "Aleksi Briclot" },
            ],
          })
        end
      end

      context 'normal' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/AKH204/' }
        it 'X loyalty' do
          detail = card.details.first
          expect(detail.name).to eq('自然に仕える者、ニッサ')
          expect(detail.loyalty).to eq("X")
        end
      end

      context 'double_faced' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/SOI243/' }
        it do
          expect(card.details.length).to eq(2)
          expect(card.details[0].to_hash).to eq({
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
            loyalty: "3",
            flavor_text: "",
            artists: [
              { english_name: "Winona Nelson" },
            ],
          })
          expect(card.details[1].to_hash).to eq({
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
            artists: [
              { english_name: "Winona Nelson" },
            ],
          })
        end
      end
    end

    describe 'Land' do

      context 'normal' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/RIX192/' }
        it do
          expect(card.details.length).to eq(1)
          expect(card.details.first.to_hash).to eq({
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
            artists: [
              { english_name: "Dimitar" },
            ],
          })
        end
      end

      context 'creature' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/FUT174/' }
        it do
          expect(card.details.length).to eq(1)
          expect(card.details.first.to_hash).to eq({
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
            power: "1",
            toughness: "1",
            flavor_text: "樹触れるべからず、枝折るべからず、答を望む問いのみを発せよ。――― ドルイドの古老、ヴォン・ヨムから彼女の信徒へ.",
            artists: [
              { english_name: "Eric Fortune" },
            ],
          })
        end
      end

      context 'multicolor' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/RTR247/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('蒸気孔')
          expect(detail.subtypes).to eq([
            { name: '島', english_name: 'Island' },
            { name: '山', english_name: 'Mountain' },
          ])
        end
      end

      context 'legendary snow' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/CSP145/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('暗黒の深部')
          expect(detail.supertypes).to eq([
            { name: '伝説の' },
            { name: '氷雪' },
          ])
        end
      end

      context 'basic snow' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/CSP151/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('冠雪の平地')
          expect(detail.supertypes).to eq([
            { name: '基本' },
            { name: '氷雪' },
          ])
        end
      end

      context 'Urza’s' do
        let(:url){ 'http://whisper.wisdom-guild.net/card/TSP280/' }
        it do
          detail = card.details.first
          expect(detail.name).to eq('ウルザの工廠')
          expect(detail.subtypes).to eq([
            { name: '', english_name: 'Urza’s' },
          ])
        end
      end

    end

  end

  context 'invalid card name' do
    let(:url){ 'http://whisper.wisdom-guild.net/card/invalid_card_name/' }
    it do
      expect(card.error?).to eq(true)
      expect(card.name).to eq(nil)
      expect(card.english_name).to eq(nil)
      expect(card.multiverseid).to eq(nil)
      expect(card.details).to eq(nil)
    end
  end

end
