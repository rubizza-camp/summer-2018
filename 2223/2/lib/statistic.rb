require_relative 'battles/parser'
require_relative 'statistics/top_swears'
require_relative 'statistics/top_words'
require_relative 'statistics/plagiary'

class Statistic
  FEATURES = {
    '--top-bad-words' => :top_swears,
    '--name' => :top_words,
    '--plagiat' => :plagiary
  }.freeze

  def self.call(params)
    Statistic.new(params).call
  end

  def initialize(params)
    @params = params.map { |str| str.split('=') }.to_h
    @rappers = Battles::Parser.rappers
  end

  def call
    params.each_key do |param|
      send(FEATURES[param]) if FEATURES[param]
    end
  end

  private

  attr_reader :params, :rappers

  def top_swears
    Statistics::TopSwears.call(rappers, params['--top-bad-words'])
  end

  def top_words
    Statistics::TopWords.call(rappers, params['--name'], params['--top-words'])
  end

  def plagiary
    Statistics::Plagiary.call(rappers, params['--plagiat'])
  end
end
