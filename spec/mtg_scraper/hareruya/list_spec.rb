RSpec.describe MtgScraper::Hareruya::List do

  let(:page){ page = MtgScraper::Page.new(url) }
  let(:html){ page.html }
  let(:list){ MtgScraper::Hareruya::List.new(html) }

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

    context do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      let(:nth){ 0 }
      it do
        expect(subject).to eq(
          name: '暴君への敵対者、アジャニ',
          english_name: 'Ajani, Adversary of Tyrants',
        )
      end
    end

    context 'out of range' do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      let(:nth){ 999 }
      it{ expect(subject).to eq nil }
    end

  end

end
