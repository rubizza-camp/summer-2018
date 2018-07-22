class Battle
  attr_reader :battle_title

  def initialize(battle_title)
    @battle_title = battle_title
  end

  def text
    Battle.read_battle(@battle_title)
  end

  def words
    text = Battle.read_battle(@battle_title)
    divide_into_words(text)
  end

  def self.read_battle(battle_title)
    battle_file = File.open(battle_title, 'r')
    content = battle_file.read
    battle_file.close
    content.tr("\n", ' ')
  end

  private

  def divide_into_words(text)
    text = Unicode.downcase(text).split(' ').select! { |word| word.match(/[^\s]+[a-zA-Z]*[а-яА-я]*[^\s]+/) }
    text.map { |word| word.gsub(/[,:;.?!«»]|&quot/, '') }
  end
end
