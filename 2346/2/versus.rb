require 'optparse'
require_relative 'class_analysis'

analyzer = Analysis.new

OptionParser.new do |parser|
  parser.on('--top-bad-words=TOP', 'Список из TOP самых нецензурных участников') do |top|
    analyzer.first_level(top.to_i)
  end
  parser.on('--top-words=', 'Самые популярные слова у участника') do |qty|
    parser.on('--name=') do |name|
      analyzer.second_level(name, qty.to_i)
    end
  end
  parser.on('--name=', 'Имя участника') do |name|
    analyzer.second_level(name, 30)
  end
  parser.on_tail('-h', '--help') do
    puts "\nПоложите папку rap-battles в папку с .rb файлами. Запустите versus.rb с нужными параметрами"
    puts
    puts parser
  end
end.parse!
