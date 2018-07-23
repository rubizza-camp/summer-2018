require_relative 'constants'
# The FilesParser responsible for parse text files
class FilesParser
  def initialize(files)
    @files = files
  end

  def parse_files
    @files.map do |file|
      next unless File.file?("./texts/#{file}")
      {
        name: file[/^.+?(?='?(а|a|ы)?\s+(против|vs))/i].strip.downcase,
        battle_text: File.read("./texts/#{file}")
      }
    end
  end
end
