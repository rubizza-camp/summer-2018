require_relative '../top_words.rb'

describe TopWords do
  let(:top_words) { TopWords.new(top_words: 6, name: 'Galat') }

  it 'is able to be created' do
    expect(top_words).to be_kind_of(TopWords)
  end

  it 'return default instance variable @amount equal 30' do
    default_top_words = TopWords.new(name: 'Galat')
    expect(default_top_words.instance_variable_get(:@amount)).to eq(30)
  end

  it 'return actual instance variable @amount' do
    expect(top_words.instance_variable_get(:@amount)).to eq(6)
  end

  it 'return actual instance variable @name' do
    expect(top_words.instance_variable_get(:@name)).to eq('Galat')
  end

  it 'has instance variable @result' do
    expect(top_words.instance_variable_get(:@result)).to eq([])
  end

  # rubocop:disable Style/EvalWithLocation
  it 'has method prepare_result' do
    top_words.instance_eval('prepare_result')
    expect(top_words.instance_variable_get(:@result)).to_not eq([])
  end
  # rubocop:enable Style/EvalWithLocation
end
