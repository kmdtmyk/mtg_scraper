# frozen_string_literal: true

RSpec.describe MtgScraper::Page do

  describe '#parser' do

    let(:page){ MtgScraper::Page.new(url) }
    subject{ page.parser }

    context do
      let(:url){ 'http://whisper.wisdom-guild.net/card/10E039/' }
      it{ expect(subject).to eq MtgScraper::WisdomGuild::Card }
    end

    context do
      let(:url){ 'http://www.hareruyamtg.com/jp/c/cM19-R/' }
      it{ expect(subject).to eq MtgScraper::Hareruya::List }
    end

    context do
      let(:url){ 'http://mtgjson.com/json/M19.json' }
      it{ expect(subject).to eq MtgScraper::Mtgjson::Set }
    end

    context do
      let(:url){ 'http://example.com/' }
      it{ expect(subject).to eq nil }
    end

  end

end
