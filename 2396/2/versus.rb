require 'json'
require 'optparse'
require 'active_support/inflector'
require 'russian'
require 'russian_obscenity'
require 'terminal-table'
require_relative 'helpers/helper'
require_relative './raper'
require_relative './bad_words_counter'
require_relative './words_in_round_counter'
require_relative './word_with_quantity'
require_relative './favorite_words'
require_relative './battle'
require_relative './battle_info'
require_relative './battle_reader'
require_relative './raper_list'
require_relative './raper_list_objects'
require_relative './console'

p Time.now
Console.new.process
p Time.now
