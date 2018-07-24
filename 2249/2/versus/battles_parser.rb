# frozen_string_literal: true

require_relative 'battle'

# Selects top battles by obscene words count
class BattlesParser
  DELIMITER_PATTERN = /#|против|vs|aka|VS/

  attr_reader :battles

  def initialize(top_artists_limit, directory)
    @directory = directory
    @top_artists_limit = top_artists_limit.to_i
    @battles = []
  end

  def fetch_battles
    @battles = parse_directory
    @battles.each(&:fetch_data)
  end

  private

  def parse_directory
    Dir["#{@directory}/*"].map { |file_path| Battle.new(file_path) }
  end
end
