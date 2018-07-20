class TopWord
  attr_reader :word, :count
  def initialize(word, count)
    @word = word
    @count = count
  end

  def show
    [@word, @count]
  end
end
