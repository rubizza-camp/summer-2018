# Class search name
class ParseString
  attr_reader :name, :split_one_command
  def search_name(title_battle)
    @name = title_battle.split(/ против | vs /i).first.split('/').last.strip
  end

  def split_one_command(argument)
    @split_one_command = argument.split('=')
  end
end
