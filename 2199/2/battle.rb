# :reek:InstanceVariableAssumption
# class Battle to collect information
class Battle
  def initialize(filename)
    @filename = filename
  end

  def bad_words_count
    words.count do |word|
      word.include?('*') || RussianObscenity.obscene?(word)
    end
  end

  def words_count
    words.count
  end

  def rounds_count
    rounds_count = text.scan(/Раунд \d/).length
    rounds_count.zero? ? 1 : rounds_count
  end

  private

  def text
    @text ||= File.read(@filename)
  end

  def words
    return @words if @words
    @words = text.scan(/[\wа-яА-ЯёЁ*]+/)
    @words.delete('***')
    @words
  end
end
