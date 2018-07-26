require_relative '../versus'

describe CommandLine do
  it 'has method wich return Hash with value, if file exist' do
    result = CommandLine.new.run
    expect(result.nil?).to be_truthy
  end
end
