class Rapper
  attr_reader :rapper

  def initialize(participant_name)
    @rapper = participant_name
  end

  def battles
    fetch_battles
  end

  def self.right_battle?(file_name, rapper)
    file_name[file_name.index('/') + 1..-1].strip.index(rapper) &&
      file_name[file_name.index('/') + 1..-1].strip.index(rapper).zero?
  end

  private

  def fetch_battles
    Dir['rap-battles/*'].select { |file_name| Rapper.right_battle?(file_name, @rapper) }
  end
end
