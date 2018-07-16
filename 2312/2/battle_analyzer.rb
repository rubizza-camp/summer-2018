require 'russian_obscenity'
require './line_analyzer'
# this class analyzes text of battle
class BattleAnalyzer
  attr_reader :battle

  def initialize(battle)
    @battle = battle
    @counter = 0
    @lyrics = ''
  end

  def rounds_amount
    IO.read(@battle).each_line { |line| @counter += 1 if line[/Раунд \d/] }
    @counter = 1 if @counter.zero?
    @counter
  end

  def all_words_amount(rapper)
    lyrics_by(rapper).split
  end

  def bad_words_amount(rapper)
    counter = 0
    all_words_amount(rapper).each { |word| counter += 1 if word.include?('*') || RussianObscenity.obscene?(word) }
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
    File.open(@battle, 'r').each_line { |line| @lyrics += ' ' + line.strip }
    @lyrics.strip
  end

  def lyrics_double(rapper)
    File.open(@battle, 'r').each_line do |line|
      line_analyzer = LineAnalyzer.new(line)
      @lyrics = line_analyzer.writable_line(rapper)
    end
    @lyrics.strip
  end

  def double?
    @battle.partition(/( против | vs )/).first.include?(' & ')
  end

  def fill_info(info, rapper)
    info[1] += rounds_amount
    info[6] += all_words_amount(rapper).size
    info[3] += bad_words_amount(rapper)
    info
  end
end
