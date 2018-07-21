require 'pry'
require 'russian_obscenity'
require 'terminal-table'
require_relative 'constants'

# :reek:TooManyInstanceVariables
class TextHandler
  def initialize(top)
    @battles_count = {}
    @bad_words_counter = {}
    @words_per_battle_counter = {}
    @words_per_round_counter = {}
    @average_words_per_round_counter = {}
    @top = top
  end

  def show_result
    calculation
    show_table
  end

  private

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
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

      words_from_text = lines.join.tr("\n", ' ').delete('.,;').split

      bad_words_count = words_from_text.select do |word|
        RussianObscenity.obscene?(word) || word.include?('*')
      end.count

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

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
  # :reek:TooManyStatements
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
  # rubocop:enable Metrics/MethodLength
end

top = (ARGV[0] || '--top-bad-words=100').split('=').last.to_i
TextHandler.new(top).show_result
