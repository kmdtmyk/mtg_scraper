# frozen_string_literal: true

RSpec.describe MtgScraper::Hareruya::List::V1 do

  let(:page){ page = MtgScraper::Page.new(url) }
  let(:html){ page.html }
  let(:list){ MtgScraper::Hareruya::List::V1.new(html) }

  describe '#card_set_name' do

    subject{ list.card_set_name }

    context do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      it{ expect(subject).to eq '基本セット2019' }
    end

  end

  describe '#each' do

    context do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
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
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      it{ expect(subject).to eq 100 }
    end

    context do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R_p2/' }
      it{ expect(subject).to eq 38 }
    end

  end

  describe '#[]' do

    context 'ENG' do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      it do
        expect(list[0]).to eq(
          name: '暴君への敵対者、アジャニ',
          english_name: 'Ajani, Adversary of Tyrants',
          language: 'English',
          price: 1680,
          basic_land: false,
          card_set_code: 'M19',
        )
      end
    end

    context 'JPN' do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      it do
        expect(list[1]).to eq(
          name: '暴君への敵対者、アジャニ',
          english_name: 'Ajani, Adversary of Tyrants',
          language: 'Japanese',
          price: 1780,
          basic_land: false,
          card_set_code: 'M19',
        )
      end
    end

    context '予約シングル' do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cGRN-R/' }
      it do
        expect(list[0]).to eq(
          name: '報奨密偵',
          english_name: 'Bounty Agent',
          language: 'English',
          price: 200,
          basic_land: false,
          card_set_code: 'GRN',
        )
      end
    end

    context 'out of range' do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      it{ expect(list[999]).to eq nil }
    end

    describe 'basic land' do

      context 'plains' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cRNA-L/' }
        it do
          expect(list[0]).to eq(
            name: '平地',
            english_name: 'Plains',
            language: 'English',
            price: 50,
            basic_land: true,
            card_set_code: 'RNA',
          )
        end
      end

      context 'island' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cRNA-L/' }
        it do
          expect(list[2]).to eq(
            name: '島',
            english_name: 'Island',
            language: 'English',
            price: 50,
            basic_land: true,
            card_set_code: 'RNA',
          )
        end
      end

      context 'swamp' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cRNA-L/' }
        it do
          expect(list[4]).to eq(
            name: '沼',
            english_name: 'Swamp',
            language: 'English',
            price: 80,
            basic_land: true,
            card_set_code: 'RNA',
          )
        end
      end

      context 'mountain' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cRNA-L/' }
        it do
          expect(list[6]).to eq(
            name: '山',
            english_name: 'Mountain',
            language: 'English',
            price: 50,
            basic_land: true,
            card_set_code: 'RNA',
          )
        end
      end

      context 'forest' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cRNA-L/' }
        it do
          expect(list[8]).to eq(
            name: '森',
            english_name: 'Forest',
            language: 'English',
            price: 50,
            basic_land: true,
            card_set_code: 'RNA',
          )
        end
      end

      context 'wastes' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cOGW-C_p2/' }
        it do
          expect(list[36]).to eq(
            name: '荒地',
            english_name: 'Wastes',
            language: 'English',
            price: 50,
            basic_land: true,
            card_set_code: 'OGW',
          )
        end
      end

    end

    context 'range' do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      it do
        expect(list[0..2].class).to eq Array
        expect(list[0..2].size).to eq 3
      end
    end

  end

end
