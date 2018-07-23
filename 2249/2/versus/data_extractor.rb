# frozen_string_literal: true

require_relative 'artist_hash_generator'

# Extracts data from parsed battles
class DataExtractor
  attr_reader :extracted_data

  def initialize(all_battles, top_artists_limit)
    @all_battles = all_battles
    @top_artists_limit = top_artists_limit.to_i
    @top_artists_battles = {}
    @extracted_data = []
  end

  def extract_data
    extract_artist = lambda do |(artist, battles)|
      @extracted_data << ArtistHashGenerator.run(artist, battles)
    end
    fetch_top_artists_battles.each(&extract_artist)
  end

  private

  def fetch_top_artists_battles
    grouped_battles = @all_battles.group_by(&:artist)
    battle_sort_rule = lambda do |(_, battles)|
      - battles.map(&:obscene_words_count).reduce(&:+)
    end
    Hash[grouped_battles.sort_by(&battle_sort_rule)].first(@top_artists_limit)
  end
end
