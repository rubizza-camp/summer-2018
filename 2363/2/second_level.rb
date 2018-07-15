load 'modules.rb'

# Class find the most popular words of battler
class TopWords
  attr_reader :name, :data
  def initialize(choosen_name, choosen_num)
    @name = choosen_name
    @num = choosen_num - 1
    @data = {}
    finding_data
    output_data
  end

  def finding_data
    Dir[File.expand_path('.') + '/rap-battles/*'].each do |file|
      name_from_file = SomeMethods.parse_name(file)
      get_words(file) if SomeMethods.compare_names(name_from_file, @name)
    end
    puts "Рэпер #{name} не известен мне. Зато мне известны:\nRickey F\nOxxxymiron\nГалат" if @data == {}
  end

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:NestedIterators
  def get_words(file_name)
    File.open(file_name, 'r') do |file|
      words = file.read.split(/Раунд 1|Раунд 2|Раунд 3/).join.downcase.split(/[, \.:?!\n\r]+/)
      words.select { |item| item.size > 4 }.each do |word|
        @data[word] = @data.key?(word) ? @data[word] + 1 : 1
      end
    end
  end

  def output_data
    data.sort_by(&:last).reverse[0..@num].each do |word|
      puts "#{word.first} #{word.last} раз"
    end
  end
end
