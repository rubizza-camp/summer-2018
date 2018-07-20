# This class parse file and return battler name and stats: rounds, words
class Parser
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    name = parse_name
    stats = parse_stats
    { name: name, stats: stats }
  end

  def parse_name
    return '(Pra(Killa\'Gramm)' if file_name.include?('(Pra(Killa\'Gramm)')
    file_name.split('/').last.split('(').first.split(/ против | vs | VS /).first.strip
  end

  private

  def parse_stats
    File.open(file_name, 'r') { |file| parse_battle_state(file) } if File.exist?(file_name)
  end

  def parse_battle_state(file)
    text = file.read.split(/Раунд 1|Раунд 2|Раунд 3/)
    { words: text.join.downcase.split(/[, \.:?!\n\r]+/), rounds: count_rounds(text) }
  end

  # that siparate method for simple method parse_battle_state
  def count_rounds(text)
    size = text.size
    size > 1 ? size - 1 : size
  end
end
