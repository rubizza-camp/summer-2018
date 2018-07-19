# frozen_string_literal: true

require 'russian_obscenity'

# Helper methods for ObscenityTracker
module ObscenityHelper
  DELIMITERS = ['против', 'vs', 'VS', 'aka', ' против'].freeze

  def self.file_belongs_to_artist?(artist, file)
    DELIMITERS.any? do |delimiter|
      file.include?("#{artist} #{delimiter}")
    end
  end

  def self.generate_terminal_row(artist_name, artist_data)
    [
      artist_name,
      "#{artist_data[:battle_sum]} баттл",
      "#{artist_data[:words_sum]} нецензурных слов",
      "#{artist_data[:bad_words]} слова на баттл",
      "#{artist_data[:words_per_round]} слов в раунде"
    ]
  end

  def self.obscene_word?(word)
    word.include?('*') || RussianObscenity.obscene?(word)
  end

  def self.fetch_all_words(file)
    File.open(file, 'r').each_line.reduce(0) do |sum, line|
      sum += line.split.size
      sum
    end.to_f
  end

  def self.fetch_rounds(file)
    text = File.read(file)
    rounds_count = text.scan(/Раунд \d/).length
    rounds_count.zero? ? 1 : rounds_count
  end

  def self.fetch_words_per_round(file)
    fetch_all_words(file).to_f / fetch_rounds(file).to_f
  end

  def self.bad_words_per_battle(words_sum, battle_sum)
    words_sum.to_f / battle_sum.to_f
  end

  def self.process_line(line)
    line.split.select do |word|
      obscene_word?(word)
    end.size
  end

  def self.fetch_words_sum(file)
    file.each_line.reduce(0) do |sum, line|
      sum += process_line(line)
      sum
    end
  end
end
