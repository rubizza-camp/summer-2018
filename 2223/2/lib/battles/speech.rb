require 'russian_obscenity'

module Battles
  class Speech
    attr_reader :raunds, :text

    def initialize(text)
      convert_text = convert_text(text)
      raund_lines = raund_lines(convert_text)
      @raunds = amount_raunds(raund_lines)
      @text = convert_text - raund_lines
    end

    def amount_bad_words
      convert_text = text.join(' ').gsub('**', '*')
      amount_asterisks = convert_text.scan('*').size
      obscenities = RussianObscenity.find(convert_text)
      amount_asterisks + obscenities.delete_if { |word| word.include?('*') }.size
    end

    def words
      text.to_s.scan(/[[:word:]]+/)
    end

    def key_words
      words.delete_if { |word| word.size < 5 }
    end

    def rhymes
      find_rhymes(1).merge(find_rhymes(2))
    end

    def find_rhymes(rhyme_type)
      text.each_with_index.map do |line, index|
        next_line = text[index + rhyme_type]
        [[last_word(line), last_word(next_line)], "#{line}\n#{next_line}"] if line && next_line
      end.compact.to_h
    end

    private

    def convert_text(text)
      text.split("\n").map do |line|
        line.gsub(/&quot;/, '')
      end.compact.map(&:strip).delete_if(&:empty?)
    end

    def last_word(line)
      line.scan(/[[:word:]]+/).last
    end

    def raund_lines(text)
      text.select { |line| line.match(/Раунд \d/) }
    end

    def amount_raunds(raund_lines)
      raund_lines.size.zero? ? 3 : raund_lines.size
    end
  end
end
