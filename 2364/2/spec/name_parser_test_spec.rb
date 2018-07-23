require_relative '../name_parser'

describe NameParser do
  it 'check parcing of name' do
    string = './rap-battles/Букер против Млечного (VERSUS FRESH BLOOD 2)'
    name = NameParser.new(string).run
    expect(name).to eq('Букер')
  end

  it 'check parcing of name' do
    string = 'Test parse name'
    name = NameParser.new(string).run
    expect(name).to eq('Test parse name')
  end

  it 'check parcing of name' do
    string = 'Гриша против Толи'
    name = NameParser.new(string).run
    expect(name).to eq('Гриша')
  end

  it 'check parcing of name' do
    string = '/Гриша vs Толи'
    name = NameParser.new(string).run
    expect(name).to eq('Гриша')
  end

  it 'check parcing of name' do
    string = 'Толя'
    name = NameParser.new(string).run
    expect(name).to eq('Толя')
  end
end
