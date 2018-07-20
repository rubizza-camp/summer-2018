# Search all words
class Word
  attr_reader :rap_files

  def initialize(rap_files)
    @rap_files = rap_files
  end

  def fetch_words
    words = []
    rap_files.each do |file|
      text = File.read(file)
      words.push(handling_text(text))
    end
    words
  end

  protected

  def handling_text(text)
    arr_words = DataBattle.clearing_text_from_garbage(text)
    arr_words.map!(&:downcase)
  end
end
