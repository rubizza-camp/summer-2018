require_relative 'comparenames'

# Class find the most popular words of battler
class TopWordsParser
  attr_reader :name
  attr_reader :data
  def initialize(choosen_name, choosen_num)
    @name = choosen_name
    @num = choosen_num - 1
    @data = {}
  end

  def call(path)
    find_name_and_words_from_files(path)
    output_words_of_battler
  end

  private

  def find_name_and_words_from_files(path)
    Dir[path].each do |file|
      battler_name = Parser.new(file).parse_name
      get_words(file) if CompareNames.new(battler_name, name).call
    end
    puts "Рэпер #{name} не известен мне. Зато мне известны:\nRickey F\nOxxxymiron\nГалат" if @data == {}
  end

  def get_words(file_name)
    File.open(file_name, 'r') do |file|
      parse_words_of_battler(file)
    end
  end

  def parse_words_of_battler(file)
    words = File.read(file).split(/Раунд 1|Раунд 2|Раунд 3/).join.downcase.split(/[, \.:?!\n\r]+/)
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
