require 'trollop' # Trollop is a commandline option parser for Ruby
require 'russian_obscenity' # Gem for filtering russian obscene language
require 'terminal-table' # Ruby ASCII Table Generator
require './utils' # Utility functions
require './top_bad_words_report'

opts = Trollop.options do
  opt %s[top-bad-words], 'Prints <i> records from the Top Bad Words', default: 0
  # opt %s[top-words], 'Prints <i> words per people or list rappers if run without --name', :default => 30
  # opt :name, 'Name of the rapper. Use with --top-words', :type => :string
end

# rules for ARGV parametrs
# Trollop::educate if ARGV.empty?
Trollop.die %s[top-bad-words], 'must be non-negative' if opts[%s[top-bad-words]] <= 0
# p opts

TopBadWordsReport.new(opts[%s[top-bad-words]]).print
