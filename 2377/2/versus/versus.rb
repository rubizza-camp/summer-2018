require 'russian_obscenity'
require_relative 'rapper_class'
require_relative 'printer_class'

option_bad_words = ARGV[0].to_s[/(?<=--top-bad-words=)\d*/]
option_words = ARGV[0].to_s[/(?<=--top-words=)\d*/]
ARGV.each { |arg| @option_name = arg.to_s[/(?<=--name=)(\w|\d|.|\s)*/] }

p = Printer.new

exp = /((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/
rappers_array = []
@files = Dir.glob('*[^.rb]')
#  -----------------------------------------------------заполнение массива реперами
@files.each do |file|  # сделать наверное методы для этого
  if rappers_array.any? { |raper| raper.name == file[exp] }
    r = rappers_array.find { |r| r.name == file[exp] }
    r.count_bad_words(file)
    r.count_words_per_round(file)
    r.find_favourite_words(file) if r.name == " #{@option_name} "
    r.battles += 1
  else
    r = Rapper.new(file)
    r.count_bad_words(file)
    r.count_words_per_round(file)
    r.find_favourite_words(file) if r.name == " #{@option_name} "
    rappers_array.push(r)
  end
end
# --------------------------------------------------------заполнение массива реперами

sorted_rappers = rappers_array.sort_by { |r| -r.bad_words }
sorted_rappers.each do |rapper|
  rapper.count_words_per_battle
end


unless option_bad_words.nil?
  if option_bad_words.to_i < sorted_rappers.size
    p.print(option_bad_words.to_i, sorted_rappers)
  else 
    puts 'Too much.'
  end
end


unless @option_name.nil?
  option_words = 30 if option_words.nil?
  current = sorted_rappers.find { |r| r.name == " #{@option_name} " }
  unless current.nil?
    p.print_words(option_words.to_i, current.fav_words)
  else
    puts "I don't know #{@option_name} but I know:" 
    sorted_rappers.each do |r|
      puts r.name
    end   
  end
end









