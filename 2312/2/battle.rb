require './line'
require 'russian_obscenity'

# this class analyzes text of battle
class Battle
  attr_reader :battle_file_path

  def initialize(battle)
    @battle_file_path = battle
  end

  def double?
    @battle_file_path.partition(/( против | vs )/).first.include?(' & ')
  end

  def fill_info(info, rapper)
    info[1] += count_rounds
    info[6] += all_words(rapper).size
    info[3] += bad_words_amount(rapper)
    info
  end

  private

  def count_rounds
    rounds = rounds_amount
    rounds.zero? ? 1 : rounds
  end

  def rounds_amount(counter = 0)
    IO.read(@battle_file_path).each_line { |line| counter += 1 if line[/Раунд \d/] }
    counter
  end

  def bad_words_amount(rapper)
    counter = 0
    all_words(rapper).each { |word| counter += 1 if word.include?('*') || RussianObscenity.obscene?(word) }
    counter
  end

  def lyrics_by(rapper = '')
    if double?
      lyrics_double(rapper).split(/[.,!?:;-]/).join(' ')
    else
      lyrics_single.split(/[.,!?:;-]/).join(' ')
    end
  end

  def lyrics_single
    lyrics = ''
    File.open(@battle_file_path, 'r').each_line { |line| lyrics += ' ' + line.strip }
    lyrics
  end

  def lyrics_double(rapper)
    lyrics = ''
    File.open(@battle_file_path, 'r').each_line do |line|
      line_analyzer = Line.new(line)
      lyrics = line_analyzer.writable_line(rapper)
    end
    lyrics
  end

  def all_words(rapper)
    lyrics_by(rapper).split
  end
end
