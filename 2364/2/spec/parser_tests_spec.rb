require_relative '../parser.rb'
require_relative '../participant.rb'
require_relative '../count_words.rb'
require_relative '../name_check.rb'
require_relative '../create_data.rb'

describe Parser do
  it 'check if class of parser Parser' do
    parser = Parser.new
    expect(Parser).to eq parser.class
  end

  it 'check how much participant new Parser have' do
    parser = Parser.new
    expect(124).to eq parser.participants.size
  end
end
