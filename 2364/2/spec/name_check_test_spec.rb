require_relative '../parser.rb'
require_relative '../participant.rb'
require_relative '../count_words.rb'
require_relative '../name_check.rb'
require_relative '../create_data.rb'

describe NameCheck do
  it 'check if class of name_check NameCheck' do
    name_check = NameCheck.new('', '')
    expect(NameCheck).to eq name_check.class
  end

  it 'check two names' do
    check = NameCheck.new('Oxxxymiron', "Oxxxymiron'a").name_check
    expect(true).to eq check
  end
end
