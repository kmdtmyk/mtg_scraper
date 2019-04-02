# frozen_string_literal: true

RSpec.describe MtgScraper::Hareruya::List::V2 do

  let(:page){ page = MtgScraper::Page.new(url) }
  let(:html){ page.html }
  let(:list){ MtgScraper::Hareruya::List::V2.new(html) }

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
