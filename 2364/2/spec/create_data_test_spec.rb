require_relative '../parser.rb'
require_relative '../participant.rb'
require_relative '../count_words.rb'
require_relative '../name_check.rb'
require_relative '../create_data.rb'

describe CreateData do
  it 'check if class of create_data CreateData' do
    create_data = CreateData.new('spec/test_file.txt')
    expect(CreateData).to eq create_data.class
  end

  it 'check finding of bad words' do
    data = CreateData.new('spec/test_file.txt').take_data
    expect(3).to eq data[:bad_words]
  end

  it 'check comparing of text' do
    string = 'хуй пизда бл*ть привет пока'
    data = CreateData.new('spec/test_file.txt').take_data
    expect(string).to eq data[:text]
  end

  it 'check counting of rounds' do
    data = CreateData.new('spec/test_file.txt').take_data
    expect(1).to eq data[:rounds]
  end
end
