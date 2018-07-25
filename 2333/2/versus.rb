Dir.glob('./{libs}/*.rb').each { |file| require file }
require 'bundler'
Bundler.require

parameters = ParametersParser.parse
rapper_registry = RapperRegistry.new

if parameters[:top_bad_words]
  analyzer = TopBadWordsAnalyzer.new(rapper_registry.rappers, parameters[:top_bad_words])
  analyzer.top_bad_words
elsif parameters[:name] && rapper_registry.search_name(parameters[:name])
  analyzer = TopWordsAnalyzer.new(rapper_registry.rappers, parameters[:name], parameters[:top_words])
  analyzer.top_words
else
  puts "Рэпер #{parameters[:name]} не известен мне. Зато мне известны:"
  rapper_registry.names.each { |item| puts item }
end
