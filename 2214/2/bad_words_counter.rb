require 'russian_obscenity'
require_relative 'battle'

class BadWordsCounter
  def initialize(battles)
    @battles = battles
  end

  def count
    files.split.select { |word| RussianObscenity.obscene?(word) || word.include?('*') }.count
  end

  private

  def files
    @battles.map(&:text).join(' ')
  end
end
