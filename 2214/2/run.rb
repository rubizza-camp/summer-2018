require_relative 'battle_expert'
require 'optparse'

restorator = BattleExpert.new
OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    restorator.describe_battlers(top_bad_words.to_i)
  end
  parser.on('--top-words=') do |top_words|
    parser.on('--name=') do |name|
      restorator.find_popular_words(name, top_words.to_i)
    end
  end
  parser.on('--name=') do |name|
    restorator.find_popular_words(name)
  end
  parser.on('--help') do
    puts 'Параметр --top-bad-words - количество выводимых самых матерных баттлеров.'
    puts 'Параметр --name - имя баттлера, для которого будет выведен его топ популярных слов.'
    puts 'Параметр --top-words - количество этих слов.'
  end
end.parse!
