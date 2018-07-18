require 'optparse'
require_relative 'class_analysis'

OptionParser.new do |parser|
  parser.on('--top-bad-words=TOP', 'Список из TOP самых нецензурных участников') do |top|
    Analysis.first_level(top.to_i)
  end
  parser.on('--top-words=', 'Самые популярные слова у участника') do |qty|
    parser.on('--name=') do |name|
      Analysis.second_level(name, qty.to_i)
    end
  end
  parser.on('--name=', 'Имя участника') do |name|
    Analysis.second_level(name, 30)
  end
  parser.on_tail('-h', '--help') do
    puts "\nПоложите папку rap-battles в папку /2/ с .rb файлами. Запустите versus.rb с нужными параметрами"
    puts
    puts parser
  end
end.parse!
