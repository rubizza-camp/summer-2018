require 'russian_obscenity'
require 'terminal-table'

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
# info[rapper_name] = [num_of_battles, num_of_rounds, aver_all_words_per_round, whole_num_of_bad_words,
#                             aver_num_of_bad_words_per_battle, words_top_list{}]
# :reek:TooManyStatements
# :reek:NestedIterators
# :reek:FeatureEnvy
def run
  ARGV.each do |command|
    all_battles = Dir.entries('./').select do |entry|
      !entry.start_with?('.') && File.exist?(entry) && File.extname(entry) == ''
    end
    all_battles.sort!
    info = collect_names(all_battles)
    if command.include?('--top-bad-words=')
      top_bad(command.split('=')[1].to_i, info, all_battles)
    elsif command.include?('--top-words=')
      top_words(command.split('=')[1].to_i)
    end
    # File.delete('rappers_name.lst')
  end
end

# :reek:TooManyStatements
# :reek:FeatureEnvy
def top_bad(num_top, info, all_battles)
  info.keys.each { |rapper| info = analyze(all_battles, rapper, info) }
  output_table = []
  counter = -1
  info.sort_by { |_key, value| value[3] }.reverse.to_h.keys.each do |rapper|
    counter += 1
    output_table[counter] = [rapper]
    output_table[counter] << "#{info[rapper][0]} battles" << "#{info[rapper][3]} bad words"
    output_table[counter] << "#{info[rapper][4]} bad words per battle" << "#{info[rapper][2]} words per round"
  end
  puts Terminal::Table.new rows: output_table[0...num_top]
end

def top_words() end

# :reek:UtilityFunction
def double?(battle)
  battle.partition(/( против | vs )/).first.include?(' & ')
end

# :reek:TooManyStatements
# :reek:FeatureEnvy
def collect_names(battles)
  names_array = []
  info = {}
  battles.each do |battle|
    rapper = battle.partition(/( против | vs | VS )/).first + ' & '
    names_array << rapper.split(' & ').first.strip
    names_array << rapper.split(' & ')[1].strip if double?(battle)
  end
  names_array.each { |name| info[name] = [0, 0, 0.0, 0, 0.0, {}] }
  info
end

# :reek:TooManyStatements
# :reek:NestedIterators
# :reek:FeatureEnvy
def analyze(all_battles, rapper, info)
  rapper_battles = []
  all_battles.each do |battle|
    rapper_battles << battle if battle.partition(/( против | vs | VS )/).first.include?(rapper)
  end
  info[rapper][0] = rapper_battles.size
  all_words = 0
  rapper_battles.each do |battle|
    counter = 0
    IO.read(battle).each_line { |line| counter += 1 if line[/Раунд \d/] }
    counter = 1 if counter.zero?
    info[rapper][1] = counter
    all_words = lyrics_from(battle, rapper).split.size
    lyrics_from(battle, rapper).split.each do |word|
      info[rapper][3] += 1 if word.include?('*') || RussianObscenity.obscene?(word)
    end
  end
  info[rapper][2] = (all_words.to_f / info[rapper][1]).round(2)
  info[rapper][4] = (info[rapper][3].to_f / info[rapper][0]).round(2)
  info = info.sort.to_h
end

# :reek:TooManyStatements
# :reek:UtilityFunction
def lyrics_from(battle, rapper = '')
  text = IO.read(battle)
  lyrics = ''
  if rapper != ''
    do_write = false
    text.each_line do |line|
      if do_write
        if line.start_with?(/\w+:/)
          do_write = false
        else
          lyrics += ' ' + line.strip
        end
      elsif line.include?("#{rapper}:")
        do_write = true
        lyrics += ' ' + line.split("#{rapper}:")[1].strip
      end
    end
  else
    text.each_line { |line| lyrics += ' ' + line.strip }
  end
  lyrics.split(/[.,!?:;-]/).join(' ')
end

run
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
