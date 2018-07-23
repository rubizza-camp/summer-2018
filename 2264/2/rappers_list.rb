# This module srore all rappers
module RappersList
  def self.find_all_rappers
    Storage.all_data.inject([]) do |array, (file_name, _file_content)|
      array << file_name.split('/').last.split(/против|VS\b|vs\b/)[0].strip
      array.uniq
    end
  end
end
