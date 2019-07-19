# frozen_string_literal: true

RSpec.describe MtgScraper::Hareruya::List::V2 do

  let(:page){ page = MtgScraper::Page.new(url) }
  let(:html){ page.html }
  let(:list){ MtgScraper::Hareruya::List::V2.new(html) }

  describe '#each' do

    context do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188' }
      it{ expect(list).to respond_to(:each) }
      it do
        count = 0
        list.each do |c|
          count += 1
        end
        expect(count).to eq list.size
      end
    end

  end

  describe '#size' do

    subject{ list.size }

    context do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188' }
      it{ expect(subject).to eq 60 }
    end

  end

  describe '#params' do

    subject{ list.params }

    context 'cardset' do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=208' }
      it{ expect(subject).to eq( card_set_name: '灯争大戦' ) }
    end

    context 'empty query' do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search' }
      it{ expect(subject).to eq( {} ) }
    end

  end

  describe '#[]' do

    context do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188' }

      example 'english foil' do
        expect(list[0]).to eq(
          name: '恩寵の天使',
          english_name: 'Angel of Grace',
          language: 'English',
          price: 3000,
          basic_land: false,
          foil: true,
          card_set_code: 'RNA',
          token: false,
          prerelease: false,
          version: nil,
        )
      end

      example 'japanese non-foil' do
        expect(list[3]).to eq(
          name: '恩寵の天使',
          english_name: 'Angel of Grace',
          language: 'Japanese',
          price: 380,
          basic_land: false,
          foil: false,
          card_set_code: 'RNA',
          token: false,
          prerelease: false,
          version: nil,
        )
      end

      example 'range' do
        expect(list[0..2].class).to eq Array
        expect(list[0..2].size).to eq 3
      end

    end

    context do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188&page=19' }

      example 'basic land' do
        expect(list[22]).to eq(
          name: '平地',
          english_name: 'Plains',
          language: 'Japanese',
          price: 80,
          basic_land: true,
          foil: false,
          card_set_code: 'RNA',
          token: false,
          prerelease: false,
          version: nil,
        )
      end

    end

    context 'prerelease' do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=183' }

      example do
        expect(list[8]).to eq(
          name: '報奨密偵',
          english_name: 'Bounty Agent',
          language: 'English',
          price: 150,
          basic_land: false,
          foil: true,
          card_set_code: 'GRN',
          token: false,
          prerelease: true,
          version: nil,
        )
      end

    end

    context 'reservation' do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=208' }

      example 'japanese' do
        expect(list[0]).to eq(
          name: '大いなる創造者、カーン',
          english_name: 'Karn, the Great Creator',
          language: 'Japanese',
          price: 1400,
          basic_land: false,
          foil: false,
          card_set_code: 'WAR',
          prerelease: false,
          token: false,
          version: nil,
        )
      end

      example 'english' do
        expect(list[1]).to eq(
          name: '大いなる創造者、カーン',
          english_name: 'Karn, the Great Creator',
          language: 'English',
          price: 1400,
          basic_land: false,
          foil: false,
          card_set_code: 'WAR',
          prerelease: false,
          token: false,
          version: nil,
        )
      end

    end

    describe 'version' do

      context 'japanese illustration' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=208' }

        example do
          expect(list[2]).to eq(
            name: '大いなる創造者、カーン',
            english_name: 'Karn, the Great Creator',
            language: 'Japanese',
            price: 2000,
            basic_land: false,
            foil: false,
            card_set_code: 'WAR',
            token: false,
            prerelease: false,
            version: '絵違い',
          )
        end

      end

      context 'Brothers Yamazaki' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=53&page=11' }

        example do
          expect(list[37]).to eq(
            name: '山崎兄弟',
            english_name: 'Brothers Yamazaki',
            language: 'Japanese',
            price: 150,
            basic_land: false,
            foil: false,
            card_set_code: 'CHK',
            token: false,
            prerelease: false,
            version: 'A',
          )
        end

        example do
          expect(list[38]).to eq(
            name: '山崎兄弟',
            english_name: 'Brothers Yamazaki',
            language: 'English',
            price: 50,
            basic_land: false,
            foil: false,
            card_set_code: 'CHK',
            token: false,
            prerelease: false,
            version: 'B',
          )
        end

      end

    end

    describe 'planeswalker deck' do

      context do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=183&page=14' }

        example do
          expect(list[10]).to eq(
            name: '嵐を呼ぶ者、ラル',
            english_name: 'Ral, Caller of Storms',
            language: 'English',
            price: 600,
            basic_land: false,
            foil: true,
            card_set_code: 'GRN',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

    end

    describe 'deck builder set' do

      context do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=167&page=20' }

        example do
          expect(list[28]).to eq(
            name: '森林の地溝',
            english_name: 'Timber Gorge',
            language: 'English',
            price: 10,
            basic_land: false,
            foil: false,
            card_set_code: 'AKH',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

    end

    describe 'typo' do

      context 'single quotation 「’」→「\'」' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=171&page=2' }

        example do
          expect(list[15]).to eq(
            name: 'オケチラ最後の慈悲',
            english_name: "Oketra's Last Mercy",
            language: 'Japanese',
            price: 50,
            basic_land: false,
            foil: false,
            card_set_code: 'HOU',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

      context 'space after comma' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=159&page=9' }

        example do
          expect(list[6]).to eq(
            name: '紅蓮の俊英、チャンドラ',
            english_name: "Chandra, Pyrogenius",
            language: 'English',
            price: 150,
            basic_land: false,
            foil: true,
            card_set_code: 'KLD',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

      context 'Tenth Edition' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=67' }

        example do
          expect(list[0]).to eq(
            name: '祖神に選ばれし者',
            english_name: "Ancestor's Chosen",
            language: 'English',
            price: 200,
            basic_land: false,
            foil: true,
            card_set_code: '10E',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

      context 'Plains' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=128&page=18' }

        example do
          expect(list[12]).to eq(
            name: '平地',
            english_name: 'Plains',
            language: 'Japanese',
            price: 100,
            basic_land: true,
            foil: true,
            card_set_code: 'M15',
            token: false,
            prerelease: false,
            version: nil,
          )

          expect(list[13]).to eq(
            name: '平地',
            english_name: 'Plains',
            language: 'English',
            price: 100,
            basic_land: true,
            foil: true,
            card_set_code: 'M15',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

      context "Baral's Expertise" do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=163&page=2' }

        example do
          expect(list[58]).to eq(
            name: 'バラルの巧技',
            english_name: "Baral's Expertise",
            language: 'English',
            price: 100,
            basic_land: false,
            foil: true,
            card_set_code: 'AER',
            token: false,
            prerelease: true,
            version: nil,
          )
        end

        example do
          expect(list[59]).to eq(
            name: 'バラルの巧技',
            english_name: "Baral's Expertise",
            language: 'Japanese',
            price: 100,
            basic_land: false,
            foil: true,
            card_set_code: 'AER',
            token: false,
            prerelease: true,
            version: nil,
          )
        end

      end

      context 'Parhelion II' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=208&colors%5B%5D=1&rarity%5B%5D=3' }

        example do
          expect(list[8]).to eq(
            name: 'パルヘリオンⅡ',
            english_name: 'Parhelion II',
            language: 'Japanese',
            price: 30,
            basic_land: false,
            foil: false,
            card_set_code: 'WAR',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

      context 'Hero of Precinct One' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188&page=1' }

        example do
          expect(list[42]).to eq(
            name: '第１管区の勇士',
            english_name: 'Hero of Precinct One',
            language: 'English',
            price: 350,
            basic_land: false,
            foil: true,
            card_set_code: 'RNA',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

      context 'foil (lowercase)' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=167&foilFlg[0]=1' }

        example do
          expect(list[9]).to eq(
            name: '選定の司祭',
            english_name: 'Anointer Priest',
            language: 'Japanese',
            price: 100,
            basic_land: false,
            foil: true,
            card_set_code: 'AKH',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

    end

    describe 'box promo' do

      context 'Nexus of Fate' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=181&page=5' }

        example do
          expect(list[42]).to eq(
            name: '運命のきずな',
            english_name: 'Nexus of Fate',
            language: 'English',
            price: 2480,
            basic_land: false,
            foil: true,
            card_set_code: 'M19',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

      context 'Tezzeret, Master of the Bridge' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=208&page=16' }

        example do
          expect(list[28]).to eq(
            name: '橋の主、テゼレット',
            english_name: 'Tezzeret, Master of the Bridge',
            language: 'Japanese',
            price: 880,
            basic_land: false,
            foil: true,
            card_set_code: 'WAR',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

    end

    describe 'Token' do

      context do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=117' }

        example do
          expect(list[0]).to eq(
            name: '天使トークン',
            english_name: nil,
            language: 'English',
            price: 60,
            basic_land: false,
            foil: false,
            card_set_code: 'M14',
            token: true,
            prerelease: false,
            version: nil,
          )
        end

      end

      context 'Punch card' do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=167&page=21' }

        example do
          expect(list[2]).to eq(
            name: 'パンチカード',
            english_name: nil,
            language: 'English',
            price: 10,
            basic_land: false,
            foil: false,
            card_set_code: 'AKH',
            token: true,
            prerelease: false,
            version: nil,
          )
        end

      end

    end

    describe 'Missing price' do

      context do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=208&foilFlg[0]=0&page=3' }

        example do
          expect(list[15]).to eq(
            name: 'ケイヤ式幽体化',
            english_name: "Kaya's Ghostform",
            language: 'Japanese',
            price: nil,
            basic_land: false,
            foil: false,
            card_set_code: 'WAR',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

    end

    describe 'Missing card set code' do

      context do
        let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=208&foilFlg[0]=0&page=10' }

        example do
          expect(list[24]).to eq(
            name: '捨て身の突進',
            english_name: "Desperate Lunge",
            language: 'English',
            price: 30,
            basic_land: false,
            foil: false,
            card_set_code: 'WAR',
            token: false,
            prerelease: false,
            version: nil,
          )
        end

      end

    end

  end

  describe 'category_list' do

    subject{ list.category_list }

    context do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188' }
      it do
        expect(subject.size).to eq 138
        expect(subject[1][:name]).to eq 'ラヴニカの献身'
        expect(subject[1][:id]).to eq 188
      end
    end

  end

  describe 'next_page_url' do

    subject{ list.next_page_url }

    context 'first page' do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188' }
      it{ expect(subject).to eq 'https://www.hareruyamtg.com/ja/products/search?cardset=188&page=2' }
    end

    context 'middle page' do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188&page=5' }
      it{ expect(subject).to eq 'https://www.hareruyamtg.com/ja/products/search?cardset=188&page=6' }
    end

    context 'last page' do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188&page=19' }
      it{ expect(subject).to eq nil }
    end

    context 'no pagination' do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search' }
      it{ expect(subject).to eq nil }
    end

  end

  describe 'total_page' do

    subject{ list.total_page }

    context 'valid page' do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188' }
      it{ expect(subject).to eq 19 }
    end

    context 'no pagination' do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search' }
      it{ expect(subject).to eq nil }
    end

  end

end
