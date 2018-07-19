require_relative '../parser.rb'
require_relative '../participant.rb'
require_relative '../count_words.rb'
require_relative '../name_check.rb'
require_relative '../create_data.rb'

describe CountWords do
  it 'check if class of count_words CountWords' do
    count_words = CountWords.new('', 0)
    expect(CountWords).to eq count_words.class
  end

  it 'count words' do
    string = 'привет привет пока пока привет'
    words = CountWords.new(string, 0).hash_words
    expect(3).to eq words[0][1]
  end
end
