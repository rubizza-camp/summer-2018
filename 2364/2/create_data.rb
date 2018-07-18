# Class for creating data
class CreateData
  attr_reader :file_name, :data, :text
  def initialize(file_name)
    @file_name = file_name
    @data = {}
    @text = nil
  end

  def take_name
    name = file_name.split('/').last.split('(').first.split(/ против | vs | VS | & | && /).first.strip
    name = '(Pra(Killa\'Gramm)' if name == ''
    name
  end

  def take_data
    File.open(file_name, 'r') do |file|
      @text = file.read
      create_data
    end
    data
  end

  def create_data
    create_rounds
    @data[:words_per_battle] = text.split(' ').size
    @data[:bad_words] = count_bw
    @data[:text] = text
    @data[:name] = take_name
  end

  def create_rounds
    text_size = text.split(/Раунд 1|Раунд 2|Раунд 3/).size
    @data[:rounds] = if text_size == 1
                       text_size
                     else
                       text_size - 1
                     end
  end

  def count_bw
    words = text.split(' ')
    words.count { |word| word.include? '*' } + RussianObscenity.find(text).size
  end
end
