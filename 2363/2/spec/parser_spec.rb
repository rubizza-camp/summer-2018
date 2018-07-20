require_relative '../parser'

describe Parser do
  it 'has method which return Hash with value, if file exist' do
    path = File.expand_path('.') + '/rap-battles/' + ' 13|47 против Лехи Медь (VERSUS BATTLE СЕЗОН 4)'
    result = Parser.new(path).call
    expect(result[:name].nil?).to be_falsy
    expect(result[:stats].nil?).to be_falsy
  end

  it 'has method which return Hash with value, if file exist' do
    test_file = 'test_parse_name'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('test_parse_name')
  end

  it 'has method which return Hash with value, if file exist' do
    test_file = 'Гриша vs Толик'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end

  it 'has method which return Hash with value, if file exist' do
    test_file = ' '
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('')
  end
end

describe Parser do
  it 'has method which return Hash with value, if file exist' do
    test_file = 'Гриша VS Толик'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end

  it 'has method which return Hash with value, if file exist' do
    test_file = 'Гриша против Толик'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end

  it 'has method which return Hash with value, if file exist' do
    test_file = '/home/ Гриша против Толик'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end

  it 'has method which return Hash with value, if file exist' do
    test_file = '/home/ Гриша против Толик (asdasd)'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end

  it 'has method which return Hash with value, if file exist' do
    test_file = 'Гриша'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша')
  end
end

describe Parser do
  it 'has method which return Hash with value, if file exist' do
    test_file = 'Гриша Гришанский'
    result = Parser.new(test_file).call
    expect(result[:name]).to eq('Гриша Гришанский')
  end

  it 'has method which parse words from empty file and return nil' do
    test_file = File.expand_path('.') + '/test_files/empty_file'
    result = Parser.new(test_file).call
    expect(result[:stats]).to eq(rounds: 0, words: [])
  end

  it 'has method which parse words from file with text(Раунд 1) and return nil' do
    test_file = File.expand_path('.') + '/test_files/round1'
    result = Parser.new(test_file).call
    expect(result[:stats]).to eq(rounds: 0, words: [])
  end

  it 'has method which parse words from file with text(\n Раунд 2 \n \n) and return nil' do
    test_file = File.expand_path('.') + '/test_files/round2'
    result = Parser.new(test_file).call
    expect(result[:stats]).to eq(rounds: 1, words: [])
  end

  it 'has method which parse words from file with text(Раунд 1\n Раунд 3\n) and return nil' do
    test_file = File.expand_path('.') + '/test_files/round3'
    result = Parser.new(test_file).call
    expect(result[:stats]).to eq(rounds: 2, words: [])
  end
end
