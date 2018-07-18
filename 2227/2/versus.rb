require 'optparse'
require 'terminal-table'
require 'russian_obscenity'
require 'pry'
require 'russian'

# Top bad rapers from versus battle
class Battles
  def initialize
    @battles = Dir.glob('rap-battles2/*')
    @battles_of_rappers = battles_of_rappers
  end

  def find_names_of_the_rappers
    all_rappers = @battles_of_rappers.each_with_object([]) do |(key, _value), names|
      names << key.split(/(против | vs)/i).first
    end
    all_rappers.map!(&:strip).uniq!
  end

  def battles_of_rappers
    @battles.each_with_object({}) do |name_of_battle, all_battles|
      all_battles[name_of_battle.split(%r{^(rap-battles2/){1}.*?})[2]] = File.read(name_of_battle)
      all_battles
    end
  end

  def find_all_battles(name)
    @battles_of_rappers.select { |battle| battle.match(/^#{name}/) }
  end

  def count_of_bad_words(name)
    text = find_all_battles(name).values.join
    count = text.count('*')
    count + RussianObscenity.find(text).size
  end

  def average_bad_words_in_battle(name)
    (count_of_bad_words(name) / number_of_battles(name).to_f).round(2)
  end

  def rounds_of_rappers(name)
    rounds = find_all_battles(name).values.join.scan(/Раунд\s[1-9]/).size
    rounds.zero? ? 3 : rounds
  end

  def count_words_in_rounds(name)
    list_of_battles = find_all_battles(name)
    words = list_of_battles.values.join(' ').split(/[[:space:]]/).size
    (words.to_f / rounds_of_rappers(name)).round(2)
  end

  def number_of_battles(name)
    find_all_battles(name).size
  end

  # :reek:TooManyStatements
  def stats_of_rappers(number)
    stats = {}
    find_names_of_the_rappers.each do |name|
      stats[name] = [number_of_battles(name), count_of_bad_words(name),
                     average_bad_words_in_battle(name), count_words_in_rounds(name)]
    end
    otsorted_stats = stats.sort_by { |_name, battle_stats| battle_stats[1] }.to_a.reverse
    otsorted_stats.first(number.to_i)
  end

  # :reek:DuplicateMethodCall
  # :reek:UtilityFunction
  def make_rows(name, battle_stats)
    [
      name,
      "#{battle_stats[0]} " + Russian.pluralize(battle_stats[0].to_i, 'баттл', 'баттла', 'баттлов'),
      "#{battle_stats[1]} нецензурных " + Russian.pluralize(battle_stats[1].to_i, 'слово', 'слова', 'слов'),
      "#{battle_stats[2]} слов на баттл",
      "#{battle_stats[3]} слов в раунде"
    ]
  end

  def make_table(number)
    rows = stats_of_rappers(number).each_with_object([]) do |(name, battle_stats), row|
      row << make_rows(name, battle_stats)
    end
    Terminal::Table.new rows: rows
  end
end

options = { 'top-bad-words' => nil }
parser = OptionParser.new do |opts|
  opts.banner = 'Info for all options'
  opts.on('--top-bad-words=number', 'top-bad-words') do |number|
    options['top-bad-words'] = number
  end
end
parser.parse!
puts Battles.new.make_table(options['top-bad-words']) unless options['top-bad-words'].nil?
