# CommandFactory.build(:curse_words_command)
# rubocop:disable Style/RedundantReturn
class WriterFactory
  # This method smells of :reek:ControlParameter
  def self.build(type, *args)
    case type
    when :terminal
      return TerminalTableWriter.new(*args)
    when :html
      return HtmlTableWriter.new(*args)
    else
      raise NotImplemented
    end
  end
end
# rubocop:enable Style/RedundantReturn
