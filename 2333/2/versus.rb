Dir.glob('./{libs}/*.rb').each { |file| require file }
require 'bundler'
Bundler.require

parameters = ParametersParser.parse
rappers_reader = RappersReader.new
rapper_registry = RapperRegistry.new(rappers_reader.rappers)

if parameters[:top_bad_words]
  analyzer = TopBadWordsAnalyzer.new(rappers_reader.rappers, parameters[:top_bad_words])
  analyzer.top_bad_words
elsif parameters[:name] && rapper_registry.search_name(parameters[:name])
  analyzer = TopWordsAnalyzer.new(rappers_reader.rappers, parameters[:name], parameters[:top_words])
  analyzer.top_words
else
  puts "Рэпер #{parameters[:name]} не известен мне. Зато мне известны:"
  rappers_reader.names.each { |item| puts item }
end
