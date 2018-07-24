require_relative '../battle'
require 'russian_obscenity'

describe Battle do
  battle = Battle.new('Dizaster', 'Скажи американец в чем сила блять')
  it 'has method which returns number of words in text' do
    expect(battle.words_in_round).to be_kind_of(Integer)
  end

  it 'has method which returns number of bad words in text' do
    expect(battle.bad_words_count).to be_kind_of(Integer)
    expect(battle.bad_words_count).to eql(1)
  end
end
