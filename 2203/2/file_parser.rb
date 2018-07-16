# This class parse all text files
class FileParser
  def self.file_list
    Dir.entries('text/')
  end
end
