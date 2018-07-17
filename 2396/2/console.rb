require 'optparse'
require './obscence_raper'

class Console
  attr_reader :options

  def initialize
    @options = {}
    parse_console
  end

  def parse_console
    OptionParser.new do |opts|
      chech_opts(opts, '--top-bad-words', :top_bad_words)
      chech_opts(opts, '--top-words', :top_words)
      chech_opts(opts, '--name', :name)

      console_help(opts)
    end.parse!
  end

  # This method smells of :reek:FeatureEnvy
  def chech_opts(opts, param, my_key)
    opts.on("#{param}=NAME") do |val|
      @options[my_key] = if val.to_i.zero?
                           val
                         else
                           val.to_i
                         end
    end
  end

  def console_help(opts)
    opts.on('-h', '--help', 'Displays Help') { show_help(opts) }
  end

  def show_help(str)
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
    ObscenceRaper.new.the_most_obscene_rappers(@options[:top_bad_words])
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
