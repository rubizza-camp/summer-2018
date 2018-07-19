module RappersList
  def self.find_all_rappers
    rappers = []
    Dir.glob('rap/*') { |file_name| rappers << file_name.split('/').last.split(/против|VS\b|vs\b/)[0].strip }
    rappers.uniq
  end
end