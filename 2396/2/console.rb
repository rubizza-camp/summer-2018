# This is class Console
class Console
  attr_reader :options

  def initialize
    @options = {}
    parse_console
  end

  def process
    battle_info = BattleInfo.new
    if @options[:top_bad_words]
      battle_info.the_most_obscene_rappers(@options[:top_bad_words].to_i)
    elsif @options[:name] && @options[:top_words]
      battle_info.find_favorite_words(@options[:name],
                                      @options[:top_words].to_i)
    else
      battle_info.find_favorite_words(@options[:name])
    end
  end

  private

  def parse_console
    OptionParser.new do |opts|
      chech_opts(opts, '--top-bad-words', :top_bad_words)
      chech_opts(opts, '--top-words', :top_words)
      chech_opts(opts, '--name', :name)

      console_help(opts)
    end.parse!
  end

  def chech_opts(opts, param, my_key)
    opts.on("#{param}=NAME") do |option|
      @options[my_key] = option
    end
  end

  def console_help(opts)
    opts.on('-h', '--help', 'Displays Help') do
      puts opts
      exit
    end
  end
end
