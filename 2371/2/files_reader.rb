require_relative 'constants'
# FilesReader responsible for reading from files
class FilesReader
  def initialize(files)
    @files = files
    @threads = []
  end

  def files_content
    @files.map do |file|
      next unless File.file?("./texts/#{file}")
      {
        name: file[/^.+?(?='?(а|a|ы)?\s+(против|vs))/i].strip.downcase,
        battle_text: File.read("./texts/#{file}")
      }
    end
  end
end
