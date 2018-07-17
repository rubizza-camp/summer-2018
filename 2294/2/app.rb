require_relative './top_bad_battlers.rb'
require_relative './top_words.rb'
require_relative './options.rb'

parameter = ParametersParser.new.options

if parameter[:top_bad_words]
  inst = TopBattlers.new
  inst.result_table(parameter[:top_bad_words].to_i)
elsif parameter[:name]
  times = parameter[:top_words] || 20
  inst = TopWords.new(times)
  inst.popular_words(parameter[:name])
end
