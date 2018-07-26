class Battle
  attr_reader :battle_title

  def initialize(title)
    @battle_title = title
  end

  def text
    read_battle
  end

  def words
    text = read_battle
    divide_into_words(text)
  end

  def rounds
    text = read_battle
    make_round_num(text)
  end

  private

  def read_battle
    File.read(battle_title).tr("\n", ' ')
  end

  def divide_into_words(text)
    text = Unicode.downcase(text).split(' ').select! { |word| word.match(/[^\s]+[a-zA-Z]*[а-яА-я]*[^\s]+/) }
    text.map { |word| word.gsub(/[,:;.?!«»]|&quot/, '') }
  end

  def make_round_num(battle_text)
    num = battle_text.scan(/Раунд [1|2|3][^\s]*/).size
    num = 1 if num.zero?
    num
  end
end
