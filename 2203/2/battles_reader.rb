require './file_parser.rb'
require './rapper.rb'

# This class work with list of all battles
class BattlesReader
  attr_reader :name, :battles_list

  def initialize(rapper_name)
    @name = rapper_name
    @battles_list = search_rapper_battles
  end

  private

  def search_rapper_battles
    FileParser.file_list.select { |files| /\b#{name} (против|vs)\b/i =~ files }
  end
end
