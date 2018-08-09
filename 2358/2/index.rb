require 'pry'
require 'russian_obscenity'
require 'terminal-table'
require_relative 'constants'

# :reek:TooManyInstanceVariables
class TextHandler
  def initialize(top, name)
    @battles_count = {}
    @bad_words_counter = {}
    @words_per_battle_counter = {}
    @words_per_round_counter = {}
    @average_words_per_round_counter = {}
    @words_counter = {}
    @top = top
    @name = name
  end
  # rubocop:disable Layout/EmptyLineBetweenDefs
  # :reek:NilCheck
  def show_result
    calculation
    if @name.nil?
      show_table
    else
      show_favorite_word
    end
  end
  # rubocop:enable Layout/EmptyLineBetweenDefs

  private

  # :reek:TooManyStatements
  # :reek:NilCheck
  # :reek:NestedIterators
  def calculation
    Dir.new(TEXTS_PATH).each do |file|
      next if file =~ /^\./
      rapper_name = file.split(/ против | VS | vs /)[0].split.join(' ')

      name_from_hash = RAPPER_NAMES.find { |_, reg| rapper_name =~ reg }

      next if name_from_hash.nil?
      rapper_name = name_from_hash.first

      lines = File.readlines("#{TEXTS_PATH}/#{file}")

      words_from_text = lines.join.tr("\n", ' ').delete('.,;!?').split

      bad_words_count = words_from_text.select do |word|
        RussianObscenity.obscene?(word) || word.include?('*')
      end.count

      if @words_counter[rapper_name]
        @words_counter[rapper_name] += words_from_text
      else
        @words_counter[rapper_name] = words_from_text
      end

      if @bad_words_counter[rapper_name]
        @bad_words_counter[rapper_name] += bad_words_count
      else
        @bad_words_counter[rapper_name] = bad_words_count
      end

      if @battles_count[rapper_name]
        @battles_count[rapper_name] += 1
      else
        @battles_count[rapper_name] = 1
      end

      if @words_per_round_counter[rapper_name]
        @words_per_round_counter[rapper_name] += words_from_text.count
      else
        @words_per_round_counter[rapper_name] = words_from_text.count
      end
    end

    RAPPER_NAMES.each do |name, _|
      @words_per_battle_counter[name] = (@bad_words_counter[name].to_f / @battles_count[name]).round(2)
      @average_words_per_round_counter[name] = @words_per_round_counter[name] / (@battles_count[name] * 3)
    end
  end
  # :reek:TooManyStatements

  # rubocop:disable Metrics/MethodLength
  def show_table
    rows = []

    @bad_words_counter.sort_by { |_, counter| counter }.reverse.first(@top).to_h.each do |name, counter|
      rows << [
        name,
        "#{@battles_count[name]} батлов",
        "#{counter} нецензурных слов",
        "#{@words_per_battle_counter[name]} cлов на баттл",
        "#{@average_words_per_round_counter[name]} слов в раунде"
      ]
    end

    table = Terminal::Table.new(
      headings: ['Рэппер', 'Батлы', 'Маты', 'Слов на батл', 'Слов в раунде'],
      rows: rows
    )
    puts table
  end

  # rubocop:disable Metrics/LineLength
  # rubocop:disable Metrics/AbcSize
  # :reek:TooManyStatements
  def show_favorite_word
    if RAPPER_NAMES[@name]
      counter_array = (@words_counter[@name] - SHORT_WORDS).group_by { |name| name }.map { |name, counter| [name, counter.count] }
      list_of_words = Hash[counter_array].sort_by { |_, counter| counter }.reverse

      list_of_words.first(@top).each do |pair|
        puts "#{pair[0]} - #{pair[1]}\n"
      end
    else
      puts "Рэпер #{@name} не известен мне. Зато мне известны:"
      RAPPER_NAMES.keys.sample(5).each do |name|
        puts "#{name}\n"
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/LineLength
  # rubocop:enable Metrics/AbcSize
end

name_argument = ARGV.find { |argv| argv =~ /name/ }
top_argument = ARGV.find { |argv| argv =~ /top/ }

top = top_argument.split('=').last.to_i if top_argument
rapper_name = name_argument.split('=').last if name_argument

TextHandler.new(top || 30, rapper_name).show_result
