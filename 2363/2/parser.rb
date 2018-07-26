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

  # that method work woth open file, continues to parse_stats
  def parse_battle_state(file)
    text = file.read.downcase.split(/раунд 1|раунд 2|раунд 3/)
    text.delete_if { |part_of_text| part_of_text.eql?('') }
    { words: text.join.downcase.split(/[, \.:?!\n\r]+/).delete_if { |word| word.eql?('') }, rounds: text.size }
  end
end
