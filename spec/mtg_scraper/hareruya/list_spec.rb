RSpec.describe MtgScraper::Hareruya::List do

  describe '#size' do

    let(:page){ page = MtgScraper::Page.new(url) }
    let(:html){ page.html }
    let(:list){ MtgScraper::Hareruya::List.new(html) }
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

end
