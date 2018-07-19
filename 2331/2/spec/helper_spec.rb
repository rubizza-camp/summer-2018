require_relative '../helper.rb'

describe Helper do
  it 'has method prepositions? returned true' do
    result = Helper.preposition?('в')
    expect(result).to be_truthy
  end

  it 'has method prepositions? returned false' do
    result = Helper.preposition?('говорить')
    expect(result).to be_falsy
  end
end
