require_relative '../countstats'

describe CountStats do
  it 'has method which return Hash with new stats if got need stats' do
    arg = { rounds: 1, number_words: 14, number_bad_words: 14, battles: 1 }
    result = CountStats.new(arg).call
    expect(result[:bad_words_per_battle]).to eq(14)
    expect(result[:words_per_round]).to eq(14)
  end
end
