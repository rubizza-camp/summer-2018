require 'bundler'
Bundler.require

Dir.glob('./{commands,factories,helpers,registries}/*.rb').each { |path| require path }

require 'pry'

reader = ReaderFactory.build(:files, './text')
writer = WriterFactory.build(:terminal)
command = CommandFactory.build(:curse_words_command, reader, writer)
command.run!
