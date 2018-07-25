class Rapper
  attr_reader :name

  def initialize(participant_name)
    @name = participant_name
  end

  def battles
    fetch_battles
  end

  private

  def fetch_battles
    battles = []
    Dir['rap-battles/*'].select! { |file_name| rapper_battle?(file_name) }.each do |title|
      battles << Battle.new(title)
    end
    battles
  end

  def rapper_battle?(file_name)
    remove_folder_name(file_name).index(name) && remove_folder_name(file_name).index(name).zero?
  end

  def remove_folder_name(file_name)
    file_name[file_name.index('/') + 1..-1].strip
  end
end
