require 'spec_helper'
require 'wisdom_guild/card'

RSpec.describe 'Card' do

  it 'attributes' do
    card = WisdomGuild::Card.new('UDS065')
    expect(card.name).to eq('ファイレクシアの抹殺者')
    expect(card.english_name).to eq('Phyrexian Negator')
    expect(card.multiverseid).to eq(207891)
  end

  describe 'details' do

    it 'Creature' do
      card = WisdomGuild::Card.new('10E039')
      expect(card.details.length).to eq(1)
      expect(card.details.first.to_hash).to match({
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
      })

      card = WisdomGuild::Card.new('AVR106')
      detail = card.details.first
      expect(detail.name).to eq('グリセルブランド')
      expect(detail.supertypes).to match([
        { name: '伝説の' },
      ])

      card = WisdomGuild::Card.new('FUT153')
      detail = card.details.first
      expect(detail.name).to eq('タルモゴイフ')
      expect(detail.power).to eq('*')
      expect(detail.toughness).to eq('1+*')

      card = WisdomGuild::Card.new('M11003')
      detail = card.details.first
      expect(detail.name).to eq('アジャニの群れ仲間')
      expect(detail.subtypes).to match([
        { name: '猫', english_name: 'Cat' },
        { name: '兵士', english_name: 'Soldier' },
      ])
    end

    it 'Instant' do
      card = WisdomGuild::Card.new('ALA033')
      expect(card.details.length).to eq(1)
      expect(card.details.first.to_hash).to match({
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

      card = WisdomGuild::Card.new('FUT042')
      detail = card.details.first
      expect(detail.name).to eq('否定の契約')
      expect(detail.colors).to match([
        { name: '青' },
      ])

      card = WisdomGuild::Card.new('LRW194')
      detail = card.details.first
      expect(detail.name).to eq('タール火')
      expect(detail.types).to match([
        { name: '部族' },
        { name: 'インスタント' },
      ])
      expect(detail.subtypes).to match([
        { name: 'ゴブリン', english_name: 'Goblin' }
      ])
    end

    it 'Sorcery' do
      card = WisdomGuild::Card.new('THS107')
      expect(card.details.length).to eq(1)
      expect(card.details.first.to_hash).to match({
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
        oracle: "Target player reveals his or her hand. You choose a nonland card from it. That player discards that card. You lose 2 life.",
        flavor_text: "「知識とは時に重荷となる。解放せよ。お主の恐怖を残らず私に解き放つのだ。」 ――― 悪夢の織り手、アショク.",
        artists: [
          { english_name: "Lucas Graciano" },
        ],
      })

      card = WisdomGuild::Card.new('TSP048')
      detail = card.details.first
      expect(detail.name).to eq('祖先の幻視')
      expect(detail.colors).to match([
        { name: '青' },
      ])

      card = WisdomGuild::Card.new('ROE001')
      detail = card.details.first
      expect(detail.name).to eq('全ては塵')
      expect(detail.types).to match([
        { name: '部族' },
        { name: 'ソーサリー' },
      ])
      expect(detail.subtypes).to match([
        { name: 'エルドラージ', english_name: 'Eldrazi' }
      ])

      card = WisdomGuild::Card.new('M10128')
      detail = card.details.first
      expect(detail.name).to eq('燃え立つ調査')
      expect(detail.artists).to match([
        { english_name: "Zoltan Boros" },
        { english_name: "Gabor Szikszai" },
      ])
    end

    it 'Enchantment' do
      card = WisdomGuild::Card.new('ULG110')
      expect(card.details.length).to eq(1)
      expect(card.details.first.to_hash).to match({
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

      card = WisdomGuild::Card.new('MIR055')
      detail = card.details.first
      expect(detail.name).to eq('不思議のバザール')
      expect(detail.supertypes).to match([
        { name: 'ワールド' },
      ])

      card = WisdomGuild::Card.new('MOR058')
      detail = card.details.first
      expect(detail.name).to eq('苦花')
      expect(detail.types).to match([
        { name: '部族' },
        { name: 'エンチャント' },
      ])
      expect(detail.subtypes).to match([
        { name: 'フェアリー', english_name: 'Faerie' }
      ])
    end

    it 'Artifact' do
      card = WisdomGuild::Card.new('LRW261')
      expect(card.details.length).to eq(1)
      expect(card.details.first.to_hash).to match({
        name: 'バネ葉の太鼓',
        english_name: 'Springleaf Drum',
        furigana: 'ばねはのたいこ',
        mana_cost: '(１)',
        supertypes: [],
        types: [
          { name: 'アーティファクト' },
        ],
        subtypes: [],
        text: "(Ｔ),あなたがコントロールするアンタップ状態のクリーチャーを１体タップする：あなたのマナ・プールに、好きな色のマナ１点を加える。",
        oracle: "{T}, Tap an untapped creature you control: Add one mana of any color to your mana pool.",
        flavor_text: "午後をかけてトビハゼを試してみた結果、スクラッチにはカワゴイの方がいい騒音を立ててくれるのがわかった。",
        artists: [
          { english_name: "Cyril Van Der Haegen" },
        ],
      })

      card = WisdomGuild::Card.new('KLD222')
      detail = card.details.first
      expect(detail.name).to eq('金属製の巨像')
      expect(detail.types).to match([
        { name: 'アーティファクト' },
        { name: 'クリーチャー' },
      ])
      expect(detail.subtypes).to match([
        { name: '構築物', english_name: 'Construct' },
      ])

      card = WisdomGuild::Card.new('KLD234')
      detail = card.details.first
      expect(detail.name).to eq('領事の旗艦、スカイソブリン')
      expect(detail.supertypes).to match([
        { name: '伝説の' },
      ])
      expect(detail.types).to match([
        { name: 'アーティファクト' },
      ])
      expect(detail.subtypes).to match([
        { name: '機体', english_name: 'Vehicle' },
      ])

      card = WisdomGuild::Card.new('MOR144')
      detail = card.details.first
      expect(detail.name).to eq('黒曜石の戦斧')
      expect(detail.types).to match([
        { name: '部族' },
        { name: 'アーティファクト' },
      ])
      expect(detail.subtypes).to match([
        { name: '戦士', english_name: 'Warrior' },
        { name: '装備品', english_name: 'Equipment' },
      ])
    end

    it 'Planeswalker' do
      card = WisdomGuild::Card.new('M11058')
      expect(card.details.length).to eq(1)
      expect(card.details.first.to_hash).to match({
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

      card = WisdomGuild::Card.new('AKH204')
      detail = card.details.first
      expect(detail.name).to eq('自然に仕える者、ニッサ')
      expect(detail.loyalty).to eq("X")
    end

    it 'Land' do
      card = WisdomGuild::Card.new('RIX192')
      expect(card.details.length).to eq(1)
      expect(card.details.first.to_hash).to match({
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

      card = WisdomGuild::Card.new('FUT174')
      expect(card.details.length).to eq(1)
      expect(card.details.first.to_hash).to match({
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

      card = WisdomGuild::Card.new('RTR247')
      detail = card.details.first
      expect(detail.name).to eq('蒸気孔')
      expect(detail.subtypes).to eq([
        { name: '島', english_name: 'Island' },
        { name: '山', english_name: 'Mountain' },
      ])

      card = WisdomGuild::Card.new('CSP145')
      detail = card.details.first
      expect(detail.name).to eq('暗黒の深部')
      expect(detail.supertypes).to eq([
        { name: '伝説の' },
        { name: '氷雪' },
      ])

      card = WisdomGuild::Card.new('CSP151')
      detail = card.details.first
      expect(detail.name).to eq('冠雪の平地')
      expect(detail.supertypes).to eq([
        { name: '基本' },
        { name: '氷雪' },
      ])
    end

  end

end
