# frozen_string_literal: true

RSpec.describe MtgScraper::Hareruya::List::V2 do

  let(:page){ page = MtgScraper::Page.new(url) }
  let(:html){ page.html }
  let(:list){ MtgScraper::Hareruya::List::V2.new(html) }

  describe '#each' do

    context do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188' }
      it{ expect(list).to respond_to(:each) }
    end

  end

  describe '#size' do

    subject{ list.size }

    context do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188' }
      it{ expect(subject).to eq 60 }
    end

  end

  describe '#[]' do

    context do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188' }

      example 'english foil' do
        expect(list[0]).to eq(
          name: '恩寵の天使',
          english_name: 'Angel of Grace',
          language: 'english',
          price: 3000,
          basic_land: false,
          foil: true,
          card_set_code: 'RNA',
        )
      end

      example 'japanese non-foil' do
        expect(list[3]).to eq(
          name: '恩寵の天使',
          english_name: 'Angel of Grace',
          language: 'japanese',
          price: 380,
          basic_land: false,
          foil: false,
          card_set_code: 'RNA',
        )
      end

    end

    context do
      let(:url){ 'https://www.hareruyamtg.com/ja/products/search?cardset=188&page=19' }

      example 'basic land' do
        expect(list[22]).to eq(
          name: '平地',
          english_name: 'Plains',
          language: 'japanese',
          price: 80,
          basic_land: true,
          foil: false,
          card_set_code: 'RNA',
        )
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
