RSpec.describe MtgScraper::Hareruya::List do

  it 'to_hash' do
    list = MtgScraper::Hareruya::List.new('cM19-R')
    list.to_hash
  end

end
