require 'optparse'
require 'fileutils'
require_relative 'first_level'
require_relative 'second_level'

# Class check command line
class CommandLine
  DEFAULT_NUMBER_TOP_WORDS = 30
  DEFAULT_NUMBER_TOP_WORDS.freeze
  PATH = File.expand_path('.') + '/rap-battles/*'

  attr_reader :number_battlers_output, :name, :number_top_words
  def run
    if check_dir
      OptionParser.new do |opts|
        check_for_bad_words(opts)
        check_num_and_name(opts)
      end.parse!
    else
      puts 'Folder \'rap-battles\' does not exist!'
    end
    output_result
  end

  private

  def check_for_bad_words(opts)
    opts.on('--top-bad-words=VALUE', 'Top of bad words') { |bad_words| @number_battlers_output = bad_words.to_i }
  end

  def check_num_and_name(opts)
    opts.on('--top-words=VALUE', 'Top of words') { |number| @number_top_words = number.to_i }
    opts.on('--name=NAME', 'Name of raper') { |value_name| @name = value_name }
  end

  def output_result
    BadWordsParser.new.call(number_battlers_output, PATH) if number_battlers_output
    TopWordsParser.new(name, number_top_words ? number_top_words : DEFAULT_NUMBER_TOP_WORDS).call(PATH) if name
  end

  # method check errors with files, i use it once, and write class for this little method so useless
  def check_dir
    file = File.expand_path('.')
    FileUtils.rm_r Dir[file] if Dir.exist?(file + '/rap-battles/__MACOSX')
    Dir.exist?(file + '/rap-battles')
  end
end

CommandLine.new.run
