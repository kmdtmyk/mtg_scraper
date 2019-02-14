# frozen_string_literal: true

RSpec.describe MtgScraper do

  it 'has a version number' do
    expect(MtgScraper::VERSION).not_to be nil
  end

  it 'has a name' do
    expect(MtgScraper::NAME).not_to be nil
  end

  describe '#url' do

    subject{ MtgScraper.url(url).class }

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
      it{ expect(subject).to eq NilClass }
    end

  end

end
