require 'russian_obscenity'
require 'terminal-table'

# info[rapper_name] = [num_of_battles, num_of_rounds, aver_all_words_per_round, whole_num_of_bad_words,
#                             aver_num_of_bad_words_per_battle, words_top_list{}

def collect_battles
  all_battles = Dir.entries('./').select do |entry|
    !entry.start_with?('.') && File.exist?(entry) && File.extname(entry) == ''
  end
  all_battles
end

def run
  all_battles = collect_battles
  ARGV.each do |command|
    all_battles.sort!
    info = collect_names(all_battles)
    if command.include?('--top-bad-words=')
      top_bad(command.split('=')[1].to_i, info, all_battles)
    elsif command.include?('--top-words=')
      top_words(command.split('=')[1].to_i)
    end
  end
end

def top_bad(num_top, info, all_battles)
  info.keys.each { |rapper| info = analyze(all_battles, rapper, info) }
  output_table = []
  fill_table_global(info, output_table)
  puts Terminal::Table.new rows: output_table[0...num_top]
end

def fill_table_global(info, output_table)
  counter = -1
  info.sort_by { |_key, value| value[3] }.reverse.to_h.keys.each do |rapper|
    counter += 1
    output_table = fill_table_first(info, rapper, output_table, counter)
    output_table = fill_table_second(info, rapper, output_table, counter)
  end
end

def fill_table_first(info, rapper, output_table, counter)
  output_table[counter] = [rapper]
  output_table[counter] << "#{info[rapper][0]} battles" << "#{info[rapper][3]} bad words"
  output_table
end

def fill_table_second(info, rapper, output_table, counter)
  output_table[counter] << "#{info[rapper][4]} bad words per battle" << "#{info[rapper][2]} words per round"
  output_table
end

def top_words() end

def double?(battle)
  battle.partition(/( против | vs )/).first.include?(' & ')
end

def collect_names(battles)
  names_array = []
  info = {}
  battles.each do |battle|
    rapper = battle.partition(/( против | vs | VS )/).first + ' & '
    names_array << rapper.split(' & ').first.strip
    names_array << rapper.split(' & ')[1].strip if double?(battle)
  end
  names_array.each { |name| info[name] = [0, 0, 0.0, 0, 0.0, {}, 0] }
  info
end

def collect_rapper_battles(all_battles, rapper)
  rapper_battles = []
  all_battles.each do |battle|
    rapper_battles << battle if battle.partition(/( против | vs | VS )/).first.include?(rapper)
  end
  rapper_battles
end

def rounds_in(battle)
  counter = 0
  IO.read(battle).each_line { |line| counter += 1 if line[/Раунд \d/] }
  counter = 1 if counter.zero?
  counter
end

def all_words_in(battle, rapper)
  lyrics_from(battle, rapper).split
end

def bad_words_in(battle, rapper)
  counter = 0
  all_words_in(battle, rapper).each { |word| counter += 1 if word.include?('*') || RussianObscenity.obscene?(word) }
  counter
end

def fill_counted_info(rapper, rapper_battles, info)
  info = fill_info(rapper, rapper_battles, info)
  info[2] = (info[6].to_f / info[1]).round(2)
  info[4] = (info[3].to_f / info[0]).round(2)
  info
end

def fill_info(rapper, rapper_battles, info)
  rapper_battles.each do |battle|
    info[1] += rounds_in(battle)
    info[6] += all_words_in(battle, rapper).size
    info[3] += bad_words_in(battle, rapper)
  end
  info
end

def analyze(all_battles, rapper, info)
  rapper_battles = collect_rapper_battles(all_battles, rapper)
  info[rapper][0] = rapper_battles.size
  info[rapper] = fill_counted_info(rapper, rapper_battles, info[rapper])
  info.sort.to_h
end

def lyrics_from(battle, rapper = false)
  if double?(battle)
    lyrics_double(battle, rapper).split(/[.,!?:;-]/).join(' ')
  else
    lyrics_single(battle).split(/[.,!?:;-]/).join(' ')
  end
end

def lyrics_double(battle, rapper)
  do_write = false
  lyrics = ''
  File.open(battle, 'r').each_line do |line|
    if do_write
      do_write = do_write?(line, rapper, do_write)
      lyrics += ' ' + line.strip if do_write
    end
  end
  lyrics.strip
end

def do_write?(line, rapper, toggle)
  return false if line.start_with?(/\w+:/)
  return true if line.include?("#{rapper}:") || toggle
end

def lyrics_single(battle)
  lyrics = ''
  File.open(battle, 'r').each_line { |line| lyrics += ' ' + line.strip }
  lyrics.strip
end

run
