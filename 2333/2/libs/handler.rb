require 'json'
require_relative 'rapper.rb'

# Handler class
module Handler
  def self.select_rapper(rappers, name)
    rappers.select { |rapper| rapper.name == name }
  end

  def self.delete_prepositions(rappers, name)
    selected_rapper = select_rapper(rappers, name)
    texts = selected_rapper[0].battles_words
    prepositions = File.read('prepositions.txt').split(',').map!(&:upcase)
    texts.reject! { |word| prepositions.include?(word.upcase) }
  end

  def self.create_rappers_array
    new_rappers_array = []
    versus_json = JSON.parse(File.read('data.json'))
    versus_json.each do |name, battles|
      new_rappers_array << Rapper.new(name, battles)
    end
    new_rappers_array
  end
end
