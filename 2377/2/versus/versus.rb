require_relative 'run'

option_bad_words = ARGV[0].to_s[/(?<=--top-bad-words=)\d*/]
option_words = ARGV[0].to_s[/(?<=--top-words=)\d*/]
ARGV.each { |arg| @option_name = arg.to_s[/(?<=--name=)(\w|\d|.|\s)*/] }

versus = Versus.new

versus.create_battle_array
versus.create_rapper_array
versus.sort_rappers
versus.find_favourite_words
versus.count_words_per_round

p = Printer.new(versus.rappers, versus.rounds)

unless option_bad_words.nil?
  if option_bad_words.to_i < versus.rappers.size
    p.print(option_bad_words.to_i)
  else
    puts 'Too much.'
  end
end

unless @option_name.nil?
  option_words = 30 if option_words.nil?
  anlsr = versus.fav_words_array.find { |txt| txt.name == " #{@option_name} " }
  if !anlsr.nil?
    p.print_words(option_words.to_i, anlsr.fav_words)
  else
    puts "I don't know #{@option_name} but I know:"
    versus.rappers.each do |r|
      puts r.name
    end
  end
end
