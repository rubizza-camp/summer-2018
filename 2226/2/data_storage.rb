# This module is used for storing data
module DataStorage
  def self.show_all_data
    Dir.glob('rap-battles/*').each_with_object({}) do |file_name, hash|
      hash[file_name] = File.read(file_name)
    end
  end
end
