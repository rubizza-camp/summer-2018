class Battle
  ROUNDS_IN_BATTLE = 3
  attr_reader :title, :text
  def initialize(title, text)
    @title = title
    @text = text
  end

  def bad_words_count
    @text.split.select { |word| RussianObscenity.obscene?(word) || word.include?('*') }.count
  end

  def words_in_round
    @text.gsub(/[\p{P}]/, ' ').split.count / ROUNDS_IN_BATTLE
  end
end
