# clas BadWordsCounter
class BadWordsCounter
  FOLDER_PATH = Dir.pwd.freeze
  attr_reader :text

  def initialize(text)
    @text = text
  end

  def run
    load_bad_words.inject(0) { |counter, bad_word| counter + text.gsub(bad_word).count }
  end

  private

  def load_bad_words
    @load_bad_words ||= File.read("#{FOLDER_PATH}/bad_words").split(',')
  end
end
