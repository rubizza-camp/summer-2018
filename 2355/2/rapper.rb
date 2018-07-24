# This class describes rapper
class Rapper
  attr_reader :name, :battle_count, :obscenity, :favourite_words

  def initialize(name)
    @name = name
    @battle_count = Dir[File.join("./rap-battles/#{name}/", '**', '*')].count { |file| File.file?(file) }
    @obscenity = []
    @favourite_words = {}
  end
end
