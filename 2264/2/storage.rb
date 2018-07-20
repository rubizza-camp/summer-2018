# This module store all text for every file
module Storage
  def self.all_data
    Dir.glob('rap/*').each_with_object({}) do |file_name, hash|
      hash[file_name] = File.read(file_name)
    end
  end
end
