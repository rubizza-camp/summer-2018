require_relative '../count_words'

describe WordsCounter do
  it 'count words' do
    string = 'привет привет пока пока привет'
    words = WordsCounter.new(string, 0).hash_words
    expect(words[0][1]).to eq(3)
  end

  it 'check top word' do
    string = 'привет привет пока пока привет'
    words = WordsCounter.new(string, 0).hash_words
    expect(words[0][0]).to eq('привет')
  end
end
