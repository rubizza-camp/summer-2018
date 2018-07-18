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
<<<<<<< HEAD
    puts "\nПоложите папку rap-battles в папку /2/ с .rb файлами. Запустите versus.rb с нужными параметрами"
=======
    puts "\nПоложите папку rap-battles в папку с .rb файлами. Запустите versus.rb с нужными параметрами"
>>>>>>> 4554c91c72e730fc4d64ac6ea8f12591c3127c54
    puts
    puts parser
  end
end.parse!
