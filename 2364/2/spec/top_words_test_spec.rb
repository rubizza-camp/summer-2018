require_relative '../parser.rb'
require_relative '../participant.rb'
require_relative '../count_words.rb'
require_relative '../name_check.rb'
require_relative '../create_data.rb'

describe TopWords do
  it 'check if class of top_words TopWords' do
    top_words = TopWords.new(0, '', [])
    expect(TopWords).to eq top_words.class
  end
end
