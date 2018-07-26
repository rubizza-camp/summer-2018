require_relative '../countwords'

describe CountWords do
  it 'has method which return Hash with zeros if arg = empty array' do
    result = CountWords.new([]).call
    expect(result[:number_words]).to eq(0)
    expect(result[:number_bad_words]).to eq(0)
  end
  it 'has method which return new Hash with stats if arg words' do
    result = CountWords.new(%w[string хуй]).call
    expect(result[:number_words]).to eq(2)
    expect(result[:number_bad_words]).to eq(1)
  end
  it 'has method which return Hash with zeros if arg = nil' do
    result = CountWords.new(nil).call
    expect(result[:number_words]).to eq(0)
    expect(result[:number_bad_words]).to eq(0)
  end
end
