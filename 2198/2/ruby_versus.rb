require 'pry'
require 'russian_obscenity'
require 'terminal-table'

# rubocop:disable Metrics/LineLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Style/ConditionalAssignment
# rubocop:disable Lint/UnusedBlockArgument
# rubocop:disable Style/HashSyntax
param_name, param_value = ARGF.argv[0].split('=')
if param_name == '--top-bad-words'
  top_bad_words = param_value.to_i
else
  puts 'invalid param'
  return
end

# This method smells of :reek:UtilityFunction
def get_active_rapper(filename)
  filename.split('/')[1].split(/ против | vs | VS /).first.strip
end

# This method smells of :reek:UtilityFunction
def count_battles(rapper)
  Dir.glob('rap-battles/*').select { |filename| filename.start_with?("rap-battles/ #{rapper}") }
end

# This method smells of :reek:UtilityFunction
def word_is_bad(word)
  word.include?('*') || RussianObscenity.obscene?(word)
end

def count_bad_words(battles)
  battles.sum { |battle| count_bad_words_in_battle(battle) }
end

# This method smells of :reek:UtilityFunction
# This method smells of :reek:NestedIterators
def count_bad_words_in_battle(battle)
  File.open(battle, 'r') do |file|
    file.read.split(/\s|,/).select { |word| word_is_bad(word) && word != '***' }.count
  end
end

# This method smells of :reek:UtilityFunction
def count_words_in_battle(battle)
  File.open(battle, 'r') do |file|
    file.read.scan(/(?!\*\*\*)[а-яА-ЯёЁ*]+/).count
  end
end

def words_in_rounds(battles)
  battles.sum { |battle| count_words_in_battle(battle) }
end

# This method smells of :reek:NestedIterators
# This method smells of :reek:UtilityFunction
# This method smells of :reek:TooManyStatements
def count_rounds(battles)
  round_count = 0
  battles.each do |battle|
    File.open(battle, 'r') do |file|
      rounds_in_file = file.read.scan(/[Рр]аунд \d+/).count
      if rounds_in_file.zero?
        round_count += 1
      else
        round_count += rounds_in_file
      end
    end
  end
  round_count
end

rappers = []

Dir.glob('rap-battles/*') do |filename|
  rappers << get_active_rapper(filename) if File.file?(filename)
end
rappers.uniq!

rappers_battles = {}
rappers.each do |rapper|
  rappers_battles[rapper] ||= {}
  battles = count_battles(rapper)
  rappers_battles[rapper][:battles_count] = battles.count
  rappers_battles[rapper][:bad_words] = count_bad_words(battles)
  rappers_battles[rapper][:bad_words_per_battle] = rappers_battles[rapper][:bad_words].to_f / battles.count
  rappers_battles[rapper][:words_per_round] = words_in_rounds(battles).to_f / count_rounds(battles)
end

rapper_statistic = rappers_battles.each_with_object([]) do |(rapper_name, rapper_data), accumulator|
  accumulator << [rapper_name, rapper_data[:battles_count], rapper_data[:bad_words], rapper_data[:bad_words_per_battle], rapper_data[:words_per_round]]
end

table = Terminal::Table.new do |t|
  t.rows = rapper_statistic.sort_by { |a, b, c, d, e| -c }.first(top_bad_words)
  t.headings = ['Рэпер', 'Кол-во баттлов', 'Кол-во нецензурных слов', 'Кол-во слов на баттл', 'Кол-во слов в раунде']
  t.style = { :border_top => false, :border_bottom => false }
end
puts table
# rubocop:enable Style/HashSyntax
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Style/ConditionalAssignment
# rubocop:enable Lint/UnusedBlockArgument
