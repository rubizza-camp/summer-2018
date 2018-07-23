# frozen_string_literal: true

# Generates artist hash with info from the battles
class ArtistHashGenerator
  def self.run(artist, artist_battles)
    new(artist, artist_battles).run
  end

  def initialize(artist, artist_battles)
    @artist = artist
    @battles = artist_battles
  end

  def run
    obscenes_sum = @battles.map(&:obscene_words_count).reduce(&:+)
    words_per_round = calculate_words_per_round(obscenes_sum).round(2)
    obscenes_per_battle = calculate_words_per_battle(obscenes_sum).round(2)
    {
      artist: @artist,
      battles: @battles.count,
      obscene_words_sum: obscenes_sum,
      obscene_words_per_battle: obscenes_per_battle,
      words_per_round: words_per_round.round(0)
    }
  end

  private

  def calculate_words_per_round(obscenes_sum)
    obscenes_sum.to_f / @battles.map(&:rounds_count).reduce(&:+)
  end

  def calculate_words_per_battle(obscenes_sum)
    obscenes_sum.to_f / @battles.length
  end
end
