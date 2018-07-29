require 'optparse'
require_relative 'analysis'

OptionParser.new do |parser|
  parser.on('--top-bad-words=TOP', 'Список из TOP самых нецензурных участников') do |top|
    Rap::Analysis.first_level(top.to_i)
  end
  parser.on('--top-words=', 'Самые популярные слова у участника') do |quantity|
    parser.on('--name=') do |name|
      Rap::Analysis.second_level(name, quantity.to_i)
    end
  end
  parser.on('--name=', 'Имя участника') do |name|
    Rap::Analysis.second_level(name, 30)
  end
  parser.on('--plagiat', 'Проанализировать тексты и найти рифмы, которые разные участники тырили у других.') do
    Rap::Analysis.third_level
  end
  parser.on_tail('-h', '--help') do
    puts "\nПоложите папку rap-battles в папку /2/ с .rb файлами. Запустите versus.rb с нужными параметрами"
    puts
    puts parser
  end
end.parse!
