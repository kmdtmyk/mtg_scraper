require 'spec_helper'
require 'mtg_scraper/hareruya'

RSpec.describe 'List' do

  it 'to_hash' do
    list = MtgScraper::Hareruya::List.new('cM19-R')
    list.to_hash
  end

end
