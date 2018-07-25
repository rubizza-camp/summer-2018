# The Parser responsible for parse content
class Parser
  attr_reader :parsed_data
  def initialize(contents)
    @contents = contents
    @parsed_data = []
  end

  def parse
    @contents.each { |content| parse_content(content) }
    @parsed_data
  end

  def parse_content(_content)
    raise NotImplementedError
  end
end
