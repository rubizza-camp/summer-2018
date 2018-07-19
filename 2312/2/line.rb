# this class analyzes provided line and returns a writeable one
class Line
  attr_reader :line

  def initialize(line)
    @line = line
  end

  def in_separate_words
    line.split.map { |word| Word.new(word) }
  end

  def writable_line(rapper)
    lyrics = ''
    do_write = false
    if do_write
      do_write = do_write?(rapper, do_write)
      lyrics += ' ' + @line.strip if do_write
    end
    lyrics
  end

  private

  def do_write?(rapper, toggle)
    if @line.start_with?(/\w+:/)
      false
    elsif @line.include?("#{rapper}:") || toggle
      true
    end
  end
end
