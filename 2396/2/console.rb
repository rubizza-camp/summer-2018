require 'optparse'
require './obscence_raper'

class Console
  attr_reader :options

  def initialize
    @options = {}
    parse_console
  end

  # This method smells of :reek:TooManyStatements
  def parse_console
    OptionParser.new do |opts|
      chech_opts(opts, '--top-bad-words', :top_bad_words, true)
      chech_opts(opts, '--top-words', :top_words, true)
      chech_opts(opts, '--name', :name, false)

      opts.on('-h', '--help', 'Displays Help') { console_help(opts) }
    end.parse!
  end

  # This method smells of :reek:LongParameterList
  # This method smells of :reek:ControlParameter
  def chech_opts(opts, param, my_key, available)
    opts.on("#{param}=NAME") do |val|
      @options[my_key] = if available
                           val.to_i
                         else
                           val
                         end
    end
  end

  def console_help(str)
    puts str
    exit
  end

  def process
    if @options[:top_bad_words]
      fetch_top_bad_words
    elsif Raper.raper?(@options[:name]) == false
      raper_not_find
    elsif Raper.raper?(@options[:name]) == true
      raper_find
    end
  end

  def fetch_top_bad_words
    ObscenceRaper.the_most_obscene_rappers(@options[:top_bad_words])
  end

  def raper_find
    raper = Raper.new(@options[:name])
    raper.fetch_files
    raper.show_favorite_words(@options[:top_words])
  end

  def raper_not_find
    puts "Рэпер #{options[:name]} не известен мне. Зато мне известны:"
    Battle.show_names_rapers
  end
end
