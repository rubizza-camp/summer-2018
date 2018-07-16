require './file_parser.rb'

# This class parse all rappers
class RapperParser
  attr_reader :list

  def initialize
    @list = rapper_list.sort.uniq
  end

  private

  def rapper_list
    array = []
    FileParser.file_list.map do |filename|
      name = filename.partition(' ').last
      array << name.partition(/( против | vs )/i).first
    end
    array.reject!(&:empty?)
  end
end
