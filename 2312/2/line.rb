# this class shows belonging of line of lyrics to rapper
class Line
  def initialize(line)
    @line = line
  end

  def belongs_to?(rapper_name, line_belongs)
    line_includes_rapper_name = @line.include?("#{rapper_name}:")
    if @line.start_with?(/\w+:/) && !line_includes_rapper_name
      false
    elsif line_includes_rapper_name || line_belongs
      true
    end
  end
end
