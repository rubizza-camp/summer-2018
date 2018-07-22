require_relative 'battle'
require_relative 'rapper'
require_relative 'printer'


option_bad_words = ARGV[0].to_s[/(?<=--top-bad-words=)\d*/]
option_words = ARGV[0].to_s[/(?<=--top-words=)\d*/]
ARGV.each { |arg| @option_name = arg.to_s[/(?<=--name=)(\w|\d|.|\s)*/] }

@rappers = []
@exp = /((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/

# ментор говорил делать это через хэш но я не особо вижу в этом смысл
files = Dir.glob('*[^.rb]') # просто делаю массив реперов только с их именами
files.each do |filename|
  unless @rappers.any? { |raper| raper.name == filename[@exp] }
    rpr = Rapper.new(filename)
    @rappers.push(rpr)
  end
end

files.each do |filename| # делаю для каждого репера массив его баттлов
  if @rappers.any? { |raper| raper.name == filename[@exp] }
    current = @rappers.find { |raper| raper.name == filename[@exp] }
    b = Battle.new(filename)
    current.battles.push(b)
  end
end

@rappers = @rappers.sort_by { |rpr| -rpr.bad_words }

p = Printer.new(@rappers)

unless option_bad_words.nil?
  if option_bad_words.to_i < @rappers.size
    p.print_first_level(option_bad_words.to_i)
  else
    puts 'Too much.'
  end
end

unless @option_name.nil?
  option_words = 30 if option_words.nil?
  current = @rappers.find { |txt| txt.name == " #{@option_name} " }
  if !current.nil?
    p.print_second_level(option_words.to_i, current.fav_words)
  else
    puts "I don't know #{@option_name} but I know:"
    versus.rappers.each do |r|
      puts r.name
    end
  end
end
