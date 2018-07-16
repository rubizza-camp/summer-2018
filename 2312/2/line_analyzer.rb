# this class analyzes the line
class LineAnalyzer
  attr_reader :line

  def initialize(line)
    @line = line
  end

  def do_write?(rapper, toggle)
    if @line.start_with?(/\w+:/)
      false
    elsif @line.include?("#{rapper}:") || toggle
      true
    end
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
end
