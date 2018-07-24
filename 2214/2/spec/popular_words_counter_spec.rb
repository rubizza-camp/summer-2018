require_relative '../popular_words_counter'

describe PopularWordsCounter do
  first_battle = Battle.new('1', 'Говно залупа пенис хер')
  second_battle = Battle.new('2', 'Главное правильно подать')
  third_battle = Battle.new('3', 'Скажи американец, в чем сила')
  battles = [first_battle, second_battle, third_battle]
  popular_words_counter = PopularWordsCounter.new(Battler.new('Oxxxymiron', battles), 5)
  it 'has method which returns array of sorted popular words' do
    expect(popular_words_counter.count).to be_kind_of(Array)
    expect(popular_words_counter.count.size).to eql(5)
  end
end
