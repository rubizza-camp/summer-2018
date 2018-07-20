require_relative '../second_level'
require_relative '../versus'
describe TopWordsParser do
  it 'has method wich return Hash with value, if file exist' do
    result = TopWordsParser.new('Grisha', 3).call(CommandLine::PATH)
    expect(result).to eq([])
    result = TopWordsParser.new('Oxxxymiron', 3).call(CommandLine::PATH)
    expect(result).to be_kind_of(Array)
  end
end
