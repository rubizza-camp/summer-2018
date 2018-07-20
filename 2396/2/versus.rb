require 'optparse'
require 'active_support/inflector'
require 'russian'
require 'russian_obscenity'
require './data_battle'
require './raper'
require './word'
require './bad_word'
require './favorite_word'
require './round'
require './console'

p Time.now
Console.new.process
p Time.now
