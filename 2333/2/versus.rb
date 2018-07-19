require_relative 'libs/parameters_parser.rb'
require_relative 'libs/handler.rb'
require_relative 'libs/top_bad_words_analyzer.rb'
require_relative 'libs/top_words_analyzer.rb'

parameters = ParametersParser.new.options
rappers = Handler.create_rappers_array

if parameters[:top_bad_words]
  analyzer = TopBadWordsAnalyzer.new(rappers, parameters[:top_bad_words])
  analyzer.top_bad_words
elsif parameters[:name]
  analyzer = TopWordsAnalyzer.new(rappers, parameters[:name], parameters[:top_words])
  analyzer.top_words
end
