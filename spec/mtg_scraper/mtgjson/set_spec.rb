# frozen_string_literal: true

RSpec.describe MtgScraper::Mtgjson::Set do

  let(:page){ page = MtgScraper::Page.new(url) }
  let(:html){ page.html }
  let(:set){ MtgScraper::Mtgjson::Set.new(html) }

  describe '#size' do

    subject{ set.size }

    context do
      let(:url){ 'http://mtgjson.com/json/M19.json' }
      it{ expect(subject).to eq 315 }
    end

  end

  describe '#[]' do

    subject{ set[nth] }

    context do
      let(:url){ 'http://mtgjson.com/json/M19.json' }
      let(:nth){ 0 }
      it{ expect(subject[:name]).to eq "Aegis of the Heavens" }
    end

  end

end
