require_relative '../top_bad_words.rb'

describe TopBadWords do
  let(:top_bad_words) { TopBadWords.new(top_bad_words: 4) }

  it 'is able to be created' do
    expect(top_bad_words).to be_kind_of(TopBadWords)
  end

  it 'return actual instance variable @amount' do
    expect(top_bad_words.instance_variable_get(:@amount)).to eq(4)
  end

  it 'has instance variable @result' do
    expect(top_bad_words.instance_variable_get(:@result)).to eq([])
  end

  # rubocop:disable Style/EvalWithLocation
  it 'has method prepare_result' do
    top_bad_words.instance_eval('prepare_result')
    expect(top_bad_words.instance_variable_get(:@result)).to_not eq([])
  end
  # rubocop:enable Style/EvalWithLocation
end
