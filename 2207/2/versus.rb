require 'terminal-table'
require 'trollop'
require_relative 'service'

opts = Trollop.options { opt :top_bad_word, 'Number of top', default: 5 }

Service.new.analize_by_obscenity(opts[:top_bad_word])
