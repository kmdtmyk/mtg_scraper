# frozen_string_literal: true

RSpec.describe MtgScraper do

  it 'has a version number' do
    expect(MtgScraper::VERSION).not_to be nil
  end

  it 'has a name' do
    expect(MtgScraper::NAME).not_to be nil
  end

end
