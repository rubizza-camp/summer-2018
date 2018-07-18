require 'terminal-table'
require_relative './top_bad_words_analyzer.rb'
require_relative './top_words_analyzer.rb'

module AnalyzerPrinter
  PATTERN = ' %-25s| %10s | %20s | %20s | %20s |'.freeze
  HEADING = ['Name',
             'Amount of battle',
             'Amount of bad words',
             'Amount of bad words on battles',
             'Amount of words on round'].freeze

  def self.print_top_bad_words(rappers)
    table = Terminal::Table.new(rows: rappers, headings: HEADING)
    table.columns.each_with_index do |_value, index|
      table.align_column(index, :center) if index > 0
    end
    puts table
  end

  def self.print_top_words(counter, put_count)
    counter = counter.sort_by { |_word, count| count }.reverse!
    counter.first(put_count.to_i).each do |word, count|
      puts "#{word} : #{count}"
    end
  end

  def self.print_rappers_names(rappers_names, name)
    puts "Рэпер #{name} не известен мне. Зато мне известны:"
    rappers_names.each { |item| puts item }
  end
end
