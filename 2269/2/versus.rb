require 'ru_propisju'

# Class that represents each Rap Singer
# :reek:Attribute
# :reek:TooManyInstanceVariables
class Raper
  def initialize(a_name)
    @name = a_name
    @words_round = 0
    @words_battle = 0
    @bad_words = 0
    @battles = 0
    @file_name = []
  end

  attr_reader :words_battle, :bad_words, :battles, :name, :file_name
  attr_accessor :words_round

  def add_battle
    @battles += 1
  end

  def add_file_name(file)
    @file_name << file
  end

  def add_words_count(count)
    @words_battle += count
  end

  def add_bad_words(count)
    @bad_words += count
  end
end

# :reek:DuplicateMethodCall
# :reek:NestedIterators
# :reek:UtilityFunction
# :reek:TooManyStatements
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
def word_counter(file_path)
  words_count = 0
  words_per_round = 0
  array_round = []
  bad_words_count = 0
  bad_words_array = []
  get_bad = File.open(Dir.pwd + '/bad word dict')

  get_bad.each_line do |line|
    words = line.split
    words.each do |word|
      bad_words_array << word
    end
  end
  file = File.open(file_path)

  file.each_line do |line|
    if line.include? 'Раунд'.downcase
      array_round << words_per_round
      words_per_round = 0
      next
    end
    words = line.split
    words.each do |word|
      word = word.gsub(/,.!?'":/, '')
      words_count += 1
      words_per_round += 1
      bad_words_array.each do |bw|
        bad_words_count += 1 if word.downcase.include? bw.downcase
      end
    end
  end
  array_round << words_per_round
  hash = { total: words_count, bad: bad_words_count, round: (array_round.sum / array_round.length) }
  hash
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength

if !ARGF.argv[0].nil?
  param = ARGF.argv[0].split('=')
  top = param[1].to_i
  if top < 1
    STDERR.puts("Aborted! Wrong parameter #{param[0]}. It can't be \"#{param[1]}\".")
    exit(false)
  end
else
  top = 1_000
end

destination = Dir.pwd + '/text'
rapers = {}
Dir.entries(destination).each do |file|
  next if ['.', '..'].include?(file)
  raper_name = file.split(' против')
  raper_name = raper_name[0].split(' vs')
  raper_name = raper_name[0].split(' VS')
  raper_name = raper_name[0].split(' aka')
  raper_name = raper_name[0].lstrip

  rapers[raper_name] = Raper.new raper_name unless rapers[raper_name]
  rapers[raper_name].add_battle
  rapers[raper_name].add_file_name file
end

rapers.each do |_key, value|
  value.file_name.each do |file|
    hash = word_counter(destination + '/' + file)
    value.add_words_count hash[:total]
    value.add_bad_words hash[:bad]
    value.words_round = hash[:round]
  end
end

delimiter = 1
rapers.sort_by { |_k, val| [-val.bad_words] }.each do |_key, value|
  break if delimiter > top
  average = value.bad_words.fdiv(value.battles).round(2)
  result = value.name.ljust(25) + ' | ' +
           value.battles.to_s.ljust(2) + ' ' +
           RuPropisju.choose_plural(value.battles, 'баттл', 'баттла', 'баттлов').ljust(7) + ' | ' +
           value.bad_words.to_s.ljust(4) + ' ' +
           RuPropisju.choose_plural(value.bad_words, 'нецензурное', 'нецензурных', 'нецензурных') + ' ' +
           RuPropisju.choose_plural(value.bad_words, 'слово', 'слова', 'слов').ljust(5) + ' | ' +
           average.to_s.ljust(6) + ' ' +
           RuPropisju.choose_plural(average, 'слово', 'слова', 'слова') + ' на баттл | '.ljust(12) +
           value.words_round.to_s.ljust(5) + ' ' +
           RuPropisju.choose_plural(value.words_round, 'слово', 'слова', 'слов').ljust(5) +
           ' в раунде |'.ljust(11)
  puts result
  delimiter += 1
end
