class TopWord
  attr_reader :word, :appearances
  def initialize(word, appearances)
    @word = word
    @appearances = appearances
  end

  def show
    [@word, @appearances]
  end
end
