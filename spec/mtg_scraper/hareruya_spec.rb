# frozen_string_literal: true

RSpec.describe MtgScraper::Hareruya do

  let(:page){ page = MtgScraper::Page.new(url) }
  let(:html){ page.html }

  describe '#parse' do

    subject{ MtgScraper::Hareruya.parse(html) }

    context do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      it{ expect(subject.class).to eq MtgScraper::Hareruya::List::V1 }
    end

    context do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188' }
      it{ expect(subject.class).to eq MtgScraper::Hareruya::List::V2 }
    end

  end

end
