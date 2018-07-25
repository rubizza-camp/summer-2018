# frozen_string_literal: true

require 'terminal-table'

# Prints extracted battles data to console
module BattlesPrinter
  def self.print(extracted_data)
    puts Terminal::Table.new(rows: generate_terminal_rows(extracted_data))
  end

  def self.generate_terminal_rows(extracted_data)
    extracted_data.map(&method(:generate_terminal_row))
  end

  def self.generate_terminal_row(data)
    [
      data[:artist],
      "#{data[:battles]} баттл",
      "#{data[:obscene_words_sum]} нецензурных слов",
      "#{data[:obscene_words_per_battle]} слова на баттл",
      "#{data[:words_per_round]} слов в раунде"
    ]
  end
end
