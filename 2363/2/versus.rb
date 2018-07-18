require 'optparse'
require 'fileutils'
require_relative 'first_level.rb'
require_relative 'second_level.rb'

# Class check command line
class CommandLine
  attr_reader :value, :name, :number_top_words

  def run
    if CommandLine.check_dir
      OptionParser.new do |opts|
        check_for_bad_words(opts)
        check_num_and_name(opts)
      end.parse!
    else
      puts 'Folder \'rap-battles\' does not exist!'
    end
    output_result
  end

  def check_for_bad_words(opts)
    opts.on('--top-bad-words=VALUE', 'Top of bad words') { |bad_words| @value = bad_words.to_i }
  end

  def check_num_and_name(opts)
    opts.on('--top-words=VALUE', 'Top of words') { |number| @number_top_words = number.to_i }
    opts.on('--name=NAME', 'Name of raper') { |value_name| @name = value_name }
  end

  def output_result
    BadWordsParser.new.call(value) if value
    TopWordsParser.new(name, number_top_words ? number_top_words : 30).call if name
  end

  def self.check_dir
    file = File.expand_path('.')
    FileUtils.rm_r Dir[file] if Dir.exist?(file + '/rap-battles/__MACOSX')
    Dir.exist?(file + '/rap-battles')
  end
end

CommandLine.new.run
