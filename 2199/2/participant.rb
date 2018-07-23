# Participant container
class Participant
  attr_reader :name

  def initialize(name, battles = [])
    @name = name
    @battles = battles
  end

  def add_battle(battle)
    Participant.new(@name, @battles + [battle])
  end

  def table_row
    [
      @name,
      "#{battles_count} #{Russian.pluralize(battles_count.to_i, 'баттл', 'баттла', 'баттлов')}",
      "#{bad_words_count} "\
      "#{Russian.pluralize(bad_words_count.to_i, 'нецензурное слово', 'нецензурных слова', 'нецензурных слов ')}",
      "#{bad_words_per_battle.round(2)} слова на баттл ",
      "#{words_per_round.round(2)} слов в раунде"
    ]
  end

  def bad_words_count
    @bad_words_count ||= @battles.sum(&:bad_words_count)
  end

  private

  def bad_words_per_battle
    bad_words_count.to_f / battles_count
  end

  def words_count
    @battles.sum(&:words_count)
  end

  def rounds_count
    @battles.sum(&:rounds_count)
  end

  def battles_count
    @battles.count
  end

  def words_per_round
    words_count / rounds_count.to_f
  end
end
