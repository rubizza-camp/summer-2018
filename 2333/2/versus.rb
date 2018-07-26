Dir.glob('./{libs}/*.rb').each { |file| require file }
require 'bundler'
Bundler.require

parameters = ParametersParser.parse
rappers_reader = RappersReader.new
rapper_registry = RapperRegistry.new(rappers_reader.rappers)

if parameters[:top_bad_words]
  analyzer = TopBadWordsAnalyzer.new(rappers_reader.rappers, parameters[:top_bad_words])
  TopBadWordsPrinter.new(analyzer.top_bad_words).print_top_bad_words
elsif parameters[:name] && rapper_registry.search_name(parameters[:name])
  analyzer = TopWordsAnalyzer.new(rappers_reader.rappers, parameters[:name])
  TopWordsPrinter.new(analyzer.top_words, parameters[:top_words]).print_top_words
else
  puts "Рэпер #{parameters[:name]} не известен мне. Зато мне известны:"
  rapper_registry.names.each { |item| puts item }
end
