# CommandFactory.build(:curse_words_command)
# rubocop:disable Style/RedundantReturn
class CommandFactory
  # This method smells of :reek:ControlParameter
  def self.build(name, *args)
    case name
    when :curse_words_command
      return CurseWordsCommand.new(*args)
    when :favorite_words_command
      return FavoriteWordsCommand.new(*args)
    else
      raise NotImplemented
    end
  end
end
# rubocop:enable Style/RedundantReturn
