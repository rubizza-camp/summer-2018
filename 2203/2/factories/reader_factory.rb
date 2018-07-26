# CommandFactory.build(:curse_words_command)
# rubocop:disable Style/RedundantReturn
class ReaderFactory
  # This method smells of :reek:ControlParameter
  def self.build(type, *args)
    case type
    when :files
      return FileReader.new(*args)
    when :youtube
      return YoutubeReader.new(*args)
    else
      raise NotImplemented
    end
  end
end
# rubocop:enable Style/RedundantReturn
