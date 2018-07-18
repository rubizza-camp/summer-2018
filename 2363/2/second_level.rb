require_relative 'modules.rb'

# Class find the most popular words of battler
class TopWordsParser
  include SomeMethods
  attr_reader :name, :data
  def initialize(choosen_name, choosen_num)
    @name = choosen_name
    @num = choosen_num - 1
    @data = {}
  end

  def call
    find_name_and_words_from_files
    output_words_of_battler
  end

  private

  def find_name_and_words_from_files
    Dir[File.expand_path('.') + '/rap-battles/*'].each do |file|
      parse_name(file)
      get_words(file) if SomeMethods.compare_names(name_from_file, name)
    end
    puts "Рэпер #{name} не известен мне. Зато мне известны:\nRickey F\nOxxxymiron\nГалат" if @data == {}
  end

  def get_words(file_name)
    File.open(file_name, 'r') do |file|
      parse_words_of_battler(file)
    end
  end

  def parse_words_of_battler(file)
    words = file.read.split(/Раунд 1|Раунд 2|Раунд 3/).join.downcase.split(/[, \.:?!\n\r]+/)
    words.each do |word|
      @data[word] = @data.key?(word) && word.size > 4 ? @data[word] + 1 : 1
    end
  end

  def output_words_of_battler
    data.sort_by(&:last).reverse[0..@num].each do |word|
      puts "#{word.first} #{word.last} раз"
    end
  end
end
