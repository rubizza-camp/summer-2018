# clas BadWordsCounter
class BadWordsCounter
  FOLDER_PATH = Dir.pwd.freeze
  attr_reader :text

  def initialize(text)
    @text = text
  end

  def run
    sum_bad_words = 0
    load_bad_words.each do |bad_word|
      sum_bad_words += text.gsub(bad_word).count
    end
    sum_bad_words
  end

  private

  def load_bad_words
    @load_bad_words ||= File.read("#{FOLDER_PATH}/bad_words").split(',')
  end
end
