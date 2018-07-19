require 'terminal-table'
require_relative './top_bad_words_analyzer.rb'
require_relative './top_words_analyzer.rb'

module AnalyzerPrinter
  HEADING = ['Name',
             'Amount of battle',
             'Amount of bad words',
             'Amount of bad words on battles',
             'Amount of words on round'].freeze
  FIRST_COLUMN = 0

  def self.table_rows_of_sorted_rappers(rappers)
    rows = rappers.map do |rapper|
      [rapper.name,
       rapper.battles.count,
       rapper.number_of_bad_words,
       rapper.bad_words_on_battle,
       rapper.words_on_round]
    end
    rows
  end

  def self.print_top_bad_words(rappers)
    table = Terminal::Table.new(rows: table_rows_of_sorted_rappers(rappers), headings: HEADING)
    table.columns.each_with_index do |_value, index|
      table.align_column(index, :center) if index > FIRST_COLUMN
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
