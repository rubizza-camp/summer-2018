require 'optparse'
require 'terminal-table'
# :reek:TooManyStatements
# :reek:UtilityFunction
# :reek:RepeatedConditional
# Top bad rapers from versus battle
class TopRapers
  def number_battles(name)
    battles = []
    Dir.glob('rap-battles2/*') do |file_name|
      battles << file_name if file_name.match?(/[^\s]#{name}/)
    end
    battles.size
  end

  def bad_words(name)
    bad_words = []
    Dir.glob('rap-battles2/*') do |file|
      if file.match?(/[^\s]#{name}/)
        text = File.read(file)
        rude_word = text.scan(/[*]/)
        bad_words << rude_word
      end
    end
    bad_words.flatten!
    bad_words.size
  end

  def uniq_names
    names = []
    Dir.entries('rap-battles2').map { |file_name| names << file_name.split(/(против | vs)/i).first }
    names.uniq!.sort!
    names = names[3..-1]
    names.map(&:strip!)
  end

  def average_bad_words(name)
    average = bad_words(name).fdiv(number_battles(name))
    average.round(2)
  end
  # :reek:NestedIterators
  # :reek:FeatureEnvy

  def words_rounds(name)
    words = 0
    Dir.glob('rap-battles2/*') do |file|
      if file.match?(/[^\s]#{name}/)
        File.read(file).each_line do |line|
          words += line.split.size
        end
      end
    end
    words / all_words(name)
  end

  def all_words(name)
    all_rounds = 0
    Dir.glob('rap-battles2/*') do |file|
      if file.match?(/[^\s]#{name}/)
        text = File.read(file)
        round = text.scan(/Раунд\s[1-9]/)
        all_rounds += round = round.size
        all_rounds += 3 if round.zero?
      end
    end
    all_rounds
  end

  def stats_of_rapers(number)
    true_stats = {}
    unformatted_stats = {}
    uniq_names.each do |val|
      unformatted_stats[val] = [number_battles(val), bad_words(val), average_bad_words(val), words_rounds(val)]
    end
    true_stats = sort_and_reverse_hash(unformatted_stats, true_stats)
    true_stats.shift
    true_stats.first(number.to_i)
  end

  def sort_and_reverse_hash(unformatted_stats, true_stats)
    unformatted_stats = unformatted_stats.sort_by { |_key, value| value[1] }
    unformatted_stats.reverse!
    unformatted_stats.each do |elem|
      true_stats[elem[0]] = elem[1]
    end
    true_stats
  end
  # :reek:FeatureEnvy
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Layout/AlignArray

  def make_table(number)
    true_stats = {}
    stats_of_rapers(number).each do |elem|
      true_stats[elem[0]] = elem[1]
    end
    rows = []
    true_stats.each do |key, value|
      rows << [key.to_s, value[0].to_s + ' баттлов', value[1].to_s + ' нецензурных слов',
      value[2].to_s + ' слова на баттл', value[3].to_s + ' слова в раунде']
    end
    Terminal::Table.new rows: rows
  end
  # rubocop:enable Layout/AlignArray
  # rubocop:enable Metrics/AbcSize

  options = { 'top-bad-words' => nil }
  parser = OptionParser.new do |opts|
    opts.banner = 'Info for all options'
    opts.on('--top-bad-words=number', 'top-bad-words') do |number|
      options['top-bad-words'] = number
    end
  end
  parser.parse!
  puts TopRapers.new.make_table(options['top-bad-words']) unless options['top-bad-words'].nil?
end
