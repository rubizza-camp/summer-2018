# This is class Battle
class Battle
  FOLDER = 'rap-battles'.freeze
  attr_reader :name, :text
  def initialize(name, text)
    @name = name
    @text = text
  end
end
