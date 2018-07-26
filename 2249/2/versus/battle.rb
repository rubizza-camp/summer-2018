# frozen_string_literal: true

require_relative 'string'

# Represents a rap battle
class Battle
  DELIMITERS = /#|против|vs|aka|VS/
  ROUND = /Раунд \d/

  attr_reader :artist, :rounds_count

  def initialize(file_path)
    @file_path = file_path
    @artist = ''
    @words = []
    @rounds_count = 0
  end

  def fetch_data
    fetch_artist_name
    fetch_words
    fetch_rounds_count
  end

  def obscene_words_count
    @words.select(&:obscene?).count
  end

  private

  def fetch_artist_name
    @artist = File.basename(@file_path).split(DELIMITERS).first.strip.freeze
  end

  def fetch_words
    File.open(@file_path, 'r') do |file|
      @words = file.entries.map(&:split).flatten.reject(&:only_spaces?).freeze
    end
  end

  def fetch_rounds_count
    File.open(@file_path, 'r') do |file|
      @rounds_count = file.read.scan(ROUND).length
    end
    @rounds_count = 1 if @rounds_count < 1
  end
end
