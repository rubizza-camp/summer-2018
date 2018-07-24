require_relative 'versus_battle'
require_relative 'printer'

option_bad_words = ARGV[0].to_s[/(?<=--top-bad-words=)\d*/]
option_words = ARGV[0].to_s[/(?<=--top-words=)\d*/]
ARGV.each { |arg| @option_name = arg.to_s[/(?<=--name=)(\w|\d|.|\s)*/] }

ver = VersusBattle.new

ver.create_rapper_array
ver.create_battle_array
ver.sort_rappers

p = Printer.new(ver.rappers)

unless option_bad_words.nil?
  if option_bad_words.to_i < ver.rappers.size
    p.print_first_level(option_bad_words.to_i)
  else
    puts 'Too much.'
  end
end

unless @option_name.nil?
  option_words ||= 30
  current = ver.rappers.find { |txt| txt.name == " #{@option_name} " }
  analyze = WordAnalyzer.new(current)
  if current
    p.print_second_level(option_words.to_i, analyze.find_favourite_words)
  else
    puts "I don't know #{@option_name} but I know:"
    ver.rappers.each do |r|
      puts r.name
    end
  end
end
