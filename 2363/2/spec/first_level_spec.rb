require_relative '../first_level'
require_relative '../versus'

describe BadWordsParser do
  it 'has method wich return Hash with value, if file exist' do
    result = BadWordsParser.new.call(2, CommandLine::PATH)
    expect(result.nil?).to be_truthy
  end
end
