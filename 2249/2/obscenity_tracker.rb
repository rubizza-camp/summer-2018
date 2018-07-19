# frozen_string_literal: true

require 'terminal-table'
require_relative 'obscenity_helper'

# Tracker of obscene words
class ObscenityTracker
  DELIMITER_PATTERN = /#|против|vs|aka|VS/
  HEADERS = [
    'raper', 'battle', 'filthy', 'words in battle', 'words in round'
  ].freeze

  include ObscenityHelper

  def initialize(directory, top_bad_words)
    @directory = directory
    @top_bad_words = top_bad_words
    @artists_hash = {}
    @current_file = nil
  end

  def run
    puts Terminal::Table.new headings: HEADERS, rows: generate_terminal_rows
  end

  private

  def generate_artists_hash
    Dir.glob("#{@directory}/*") do |file_path|
      @current_file = File.open(file_path, 'r')
      @artists_hash.merge!(process_current_file)
    end
  end

  def process_current_file
    artist_name = fetch_artist_name
    { artist_name => generate_artist_hash(artist_name) }
  end

  def generate_terminal_rows
    generate_artists_hash
    sort_artist_hash.map do |key, value|
      ObscenityHelper.generate_terminal_row(key, value)
    end
  end

  def generate_artist_hash(artist_name)
    words_sum = ObscenityHelper.fetch_words_sum(@current_file)
    battle_sum = fetch_battles_sum(artist_name)
    bad_words = ObscenityHelper.bad_words_per_battle(words_sum, battle_sum)
    wrap_hash(battle_sum, words_sum, bad_words)
  end

  def wrap_hash(battle_sum, words_sum, bad_words)
    words_per_round = ObscenityHelper.fetch_words_per_round(@current_file)

    {
      battle_sum: battle_sum,
      words_sum: words_sum,
      bad_words: bad_words,
      words_per_round: words_per_round.round(0)
    }
  end

  def sort_artist_hash
    @artists_hash.sort_by do |_, artist_data|
      - artist_data[:words_sum]
    end.first(@top_bad_words.to_i)
  end

  def fetch_artist_name
    File.basename(@current_file).split(DELIMITER_PATTERN).first.strip
  end

  def fetch_battles_sum(artist)
    Dir["#{@directory}/*"].select do |file|
      ObscenityHelper.file_belongs_to_artist?(artist, file)
    end.size
  end
end
