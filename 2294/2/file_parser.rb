require 'rails'
# Parse files and creates hash of names and text
class FileParser
  attr_reader :rapers, :name

  TEXT_FOLDER = './rap-battles/'.freeze
  NAME_FORMAT_REGEXP = [["[^(ха)]?('a)$|('а)$|а$|a$", ''], ['(от)$', 'ота'],
                        ['(lata)$', 'lat'], ['(stara)$', 'star'], ['хова$', 'хов'],
                        ['(ги)$', 'га'], ["(хл)\b", 'хол'], ["(ьи\b)", 'ья'], ["(ая\b)", 'ай'],
                        ['(бы)$', 'ба'], ['ного$', 'ный'], ['ого$', 'ий'], ['(ема)', 'ем'],
                        ["ни\b", 'ня'], ["ы\b", 'а'], ['(CL)', 'Cl'],
                        %w[Вити Витя], ['^t', 'T'], ['(дов$)', 'дова'],
                        ["соня\sмармеладова", 'Гнойный'], ['(za)', 'ze']].freeze

  def initialize
    @rapers = Hash.new { |hash, key| hash[key] = [] }
  end

  def read_files
    Dir.foreach(TEXT_FOLDER) do |file|
      next if File.directory?(file)
      @name = file.split(/против|aka|vs\b/i).first.strip
      parse(file)
    end
    rapers_data
  end

  private

  def format_name
    NAME_FORMAT_REGEXP.each do |pattern|
      name.sub!(Regexp.new(pattern.first, Regexp::IGNORECASE), pattern.last)
    end
    name
  end

  def split_lines(lines)
    lines.map! { |line| line.scan(/[[A-яё]\*\'[A-яё]*\d]+/) }
    @rapers[format_name] << lines.flatten.join(' ').downcase
  end

  def parse(file)
    File.open("#{TEXT_FOLDER}#{file}") do |file_name|
      lines = file_name.readlines
      split_lines(lines)
    end
  end

  def rapers_data
    rapers
  end
end
