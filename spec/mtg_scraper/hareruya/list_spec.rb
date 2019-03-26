# frozen_string_literal: true

RSpec.describe MtgScraper::Hareruya::List do

  let(:page){ page = MtgScraper::Page.new(url) }
  let(:html){ page.html }
  let(:list){ MtgScraper::Hareruya::List.new(html) }

  describe '#card_set_name' do

    subject{ list.card_set_name }

    context do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      it{ expect(subject).to eq '基本セット2019' }
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

    subject{ list[nth] }

    context 'ENG' do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      let(:nth){ 0 }
      it do
        expect(subject).to eq(
          name: '暴君への敵対者、アジャニ',
          english_name: 'Ajani, Adversary of Tyrants',
          language: 'english',
          price: 1680,
          basic_land: false,
        )
      end
    end

    context 'JPN' do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      let(:nth){ 1 }
      it do
        expect(subject).to eq(
          name: '暴君への敵対者、アジャニ',
          english_name: 'Ajani, Adversary of Tyrants',
          language: 'japanese',
          price: 1780,
          basic_land: false,
        )
      end
    end

    context '予約シングル' do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cGRN-R/' }
      let(:nth){ 0 }
      it do
        expect(subject).to eq(
          name: '報奨密偵',
          english_name: 'Bounty Agent',
          language: 'english',
          price: 200,
          basic_land: false,
        )
      end
    end

    context 'out of range' do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      let(:nth){ 999 }
      it{ expect(subject).to eq nil }
    end

    describe 'basic land' do

      context 'plains' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cRNA-L/' }
        let(:nth){ 0 }
        it do
          expect(subject).to eq(
            name: '平地',
            english_name: 'Plains',
            language: 'english',
            price: 50,
            basic_land: true,
          )
        end
      end

      context 'island' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cRNA-L/' }
        let(:nth){ 2 }
        it do
          expect(subject).to eq(
            name: '島',
            english_name: 'Island',
            language: 'english',
            price: 50,
            basic_land: true,
          )
        end
      end

      context 'swamp' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cRNA-L/' }
        let(:nth){ 4 }
        it do
          expect(subject).to eq(
            name: '沼',
            english_name: 'Swamp',
            language: 'english',
            price: 80,
            basic_land: true,
          )
        end
      end

      context 'mountain' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cRNA-L/' }
        let(:nth){ 6 }
        it do
          expect(subject).to eq(
            name: '山',
            english_name: 'Mountain',
            language: 'english',
            price: 50,
            basic_land: true,
          )
        end
      end

      context 'forest' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cRNA-L/' }
        let(:nth){ 8 }
        it do
          expect(subject).to eq(
            name: '森',
            english_name: 'Forest',
            language: 'english',
            price: 50,
            basic_land: true,
          )
        end
      end

      context 'wastes' do
        let(:url){ 'http://www.hareruyamtg.com/jp/c/cOGW-C_p2/' }
        let(:nth){ 36 }
        it do
          expect(subject).to eq(
            name: '荒地',
            english_name: 'Wastes',
            language: 'english',
            price: 50,
            basic_land: true,
          )
        end
      end

    end

  end

end
