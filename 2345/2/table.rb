require 'russian'

# Configuration of the table with the results
class CreateTable < Rapper
  HEADER = [
    'Participant',
    'Number of battles',
    'Swear words',
    'Swear words in battle',
    'Swear words in round'
  ].freeze

  def self.table(top_rappers)
    {
      headings: HEADER,
      rows: top_rappers.map(&method(:table_row)),
      style: { alignment: :center, all_separators: true }
    }
  end

  def self.table_row(rapper)
    [
      rapper.name,
      battle(rapper.battles_count),
      "#{rapper.bad_words_count} нецензурных слов",
      "#{rapper.bad_words_per_battle.round(2)} слова на баттл ",
      "#{rapper.words_per_round.round(2)} слов в раунде"
    ]
  end

  def self.battle(battles)
    "#{battles} #{Russian.p(battles, 'батл', 'батла', 'батлов')}"
  end
end
