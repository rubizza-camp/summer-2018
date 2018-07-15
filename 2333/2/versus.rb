require_relative 'libs/options_parser.rb'
require_relative 'libs/handler.rb'
require_relative 'libs/analyzer.rb'

parameters = ParametersParser.new.options
rappers = Handler.create_rappers_array

if parameters[:top_bad_words]
  versus_analyzer = Analyzer.new(rappers, parameters[:top_bad_words])
  versus_analyzer.top_bad_words
elsif parameters[:name]
  put_count = parameters[:top_words] || 30
  versus_analyzer = Analyzer.new(rappers, put_count, parameters[:name])
  versus_analyzer.top_words
end
