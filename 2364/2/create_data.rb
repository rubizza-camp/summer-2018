require_relative 'name_checker'
require_relative 'name_parser'
require 'russian_obscenity'

# Class for creating data
class DataCreater
  attr_reader :file_name, :data, :text

  def initialize(file_name)
    @file_name = file_name
    @data = {}
    @text = nil
  end

  def run
    @text = File.read(file_name)
    create_data
    data
  end

  private

  def create_data
    create_rounds
    @data[:words_per_battle] = text.split(' ').size
    @data[:bad_words] = count_bad_words
    @data[:name] = NameParser.new(file_name).run
  end

  def create_rounds
    text_size = text.split(/Раунд 1|Раунд 2|Раунд 3/).size
    @data[:rounds] = if text_size == 1
                       text_size
                     else
                       text_size - 1
                     end
  end

  def count_bad_words
    words = text.split(' ')
    words.count { |word| word.include? '*' } + RussianObscenity.find(text).size
  end
end
