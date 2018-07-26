require 'russian_obscenity'

module Battles
  class Speech
    SNOW_RHYME = 1
    CROSS_RHYME = 2
    DEFAULT_SIZE_KEY_WORDS = 3
    DEFAULT_NUMBER_ROUNDS = 3

    attr_reader :rounds, :text

    def initialize(text)
      convert_text = convert_text(text)
      round_lines = round_lines(convert_text)
      @rounds = total_rounds(round_lines)
      @text = convert_text - round_lines
    end

    def total_bad_words
      convert_text = text.join(' ').gsub('**', '*')
      total_asterisks = convert_text.scan('*').size
      obscenities = RussianObscenity.find(convert_text)
      total_asterisks + obscenities.delete_if { |word| word.include?('*') }.size
    end

    def words
      text.to_s.scan(/[[:word:]]+/)
    end

    def total_words
      words.size
    end

    def key_words(unnecessary_words)
      words.reject do |word|
        word.size < DEFAULT_SIZE_KEY_WORDS || unnecessary_words.include?(word)
      end
    end

    def rhymes
      find_rhymes(SNOW_RHYME).merge(find_rhymes(CROSS_RHYME))
    end

    def find_rhymes(rhyme_type)
      text.each_with_index.map do |line, index|
        next_line = text[index + rhyme_type]
        [[last_word(line), last_word(next_line)], "#{line}\n#{next_line}"] if line && next_line
      end.compact.to_h
    end

    private

    def convert_text(text)
      text.split("\n").each_with_object([]) do |line, valid_text|
        valid_line = line.gsub(/&quot;/, '').strip
        valid_text << valid_line unless valid_line.empty?
      end
    end

    def last_word(line)
      line.scan(/[[:word:]]+/).last
    end

    def round_lines(text)
      text.select { |line| line.match(/Раунд \d/) }
    end

    def total_rounds(round_lines)
      round_lines.size.zero? ? DEFAULT_NUMBER_ROUNDS : round_lines.size
    end
  end
end
