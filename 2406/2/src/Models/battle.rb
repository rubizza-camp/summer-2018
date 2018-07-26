class Battle
  attr_reader :artist, :text_of_battle

  def initialize(artist, text_of_battle)
    @artist = artist
    @text_of_battle = text_of_battle
  end
end
