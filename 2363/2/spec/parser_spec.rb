require_relative '../parser'

describe Parser do
  it 'has method which return Hash with value, if file does not exist' do
    path = File.expand_path('.') + '/rap-battles/' + ' 13|47 против Лехи Медь (VERSUS BATTLE СЕЗОН 4)'
    result = Parser.new(path).call
    expect(result[:name].nil?).to be_falsy
    expect(result[:stats].nil?).to be_falsy
  end

  it 'has method which return Hash with value, if file does not exist' do
    test_file = 'test_parse_name'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('test_parse_name')
  end

  it 'has method which return Hash with value, if file does not exist' do
    test_file = 'Гриша vs Толик'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end

  it 'has method which return Hash with value, if file does not exist' do
    test_file = ' '
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('')
  end
end

describe Parser do
  it 'has method which return Hash with value, if file does not exist' do
    test_file = 'Гриша VS Толик'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end

  it 'has method which return Hash with value, if file does not exist' do
    test_file = 'Гриша против Толик'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end

  it 'has method which return Hash with value, if file does not exist' do
    test_file = '/home/ Гриша против Толик'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end

  it 'has method which return Hash with value, if file does not exist' do
    test_file = '/home/ Гриша против Толик (asdasd)'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end

  it 'has method which return Hash with value, if file does not exist' do
    test_file = 'Гриша'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end
end

describe Parser do
  it 'has method which return Hash with value, if file does not exist' do
    test_file = 'Гриша Гришанский'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша Гришанский')
  end

  it 'has method which parse words from empty file and return empty hash' do
    test_file = File.expand_path('.') + '/test_files/empty_file'
    result = Parser.new(test_file).call
    expect(result[:stats]).to eq(rounds: 0, words: [])
  end

  it 'has method which parse words from file with text and return empty hash' do
    test_file = File.expand_path('.') + '/test_files/round1'
    result = Parser.new(test_file).call
    expect(result[:stats]).to eq(rounds: 0, words: [])
  end

  it 'has method which parse words from file with text and return hash' do
    test_file = File.expand_path('.') + '/test_files/round3'
    result = Parser.new(test_file).call
    expect(result[:stats]).to eq(rounds: 1, words: [])
  end
end

describe Parser do
  it 'has method which parse words from file with text' do
    test_file = File.expand_path('.') + '/test_files/round4'
    result = Parser.new(test_file).call
    expect(result[:stats]).to eq(rounds: 2, words: [])
  end

  it 'has method which parse words from file with text' do
    test_file = File.expand_path('.') + '/test_files/round5'
    result = Parser.new(test_file).call
    expect(result[:stats]).to eq(rounds: 3, words: %w[word1 word2 word3])
  end

  it 'has method which parse words from file with text' do
    test_file = File.expand_path('.') + '/test_files/round6'
    result = Parser.new(test_file).call
    expect(result[:stats]).to eq(rounds: 1, words: %w[word1 word2 word3])
  end
end
