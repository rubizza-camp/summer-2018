require_relative 'libs/options_parser.rb'
require_relative 'libs/handler.rb'
require_relative 'libs/top_bad_words_analyzer.rb'
require_relative 'libs/top_words_analyzer.rb'

parameters = ParametersParser.new.options
rappers = Handler.create_rappers_array
DEFAULT_AMOUNT = 30

if parameters[:top_bad_words]
  analyzer = TopBadWordsAnalyzer.new(rappers, parameters[:top_bad_words])
  analyzer.top_bad_words
elsif parameters[:name]
  parameters[:top_words] ||= DEFAULT_AMOUNT
  analyzer = TopWordsAnalyzer.new(rappers, parameters[:top_words], parameters[:name])
  analyzer.top_words
end
