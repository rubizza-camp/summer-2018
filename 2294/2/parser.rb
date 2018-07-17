require 'rails'
# Parse files and creates hash of names and text
class Parser
  attr_reader :rapers, :name

  NAME_FORMAT_REGEXP = [["[^(ха)]?('a)$|('а)$|а$|a$", ''], ['(от)$', 'ота'],
                        ['(lata)$', 'lat'], ['(stara)$', 'star'], ['хова$', 'хов'],
                        ['(ги)$', 'га'], ["(хл)\b", 'хол'], ["(ьи\b)", 'ья'], ["(ая\b)", 'ай'],
                        ['(бы)$', 'ба'], ['ного$', 'ный'], ['ого$', 'ий'], ['(ема)', 'ем'],
                        ["ни\b", 'ня'], ["ы\b", 'а'], ['(CL)', 'Cl'],
                        %w[Вити Витя], ['^t', 'T'], ['(дов$)', 'дова'],
                        ["соня\sмармеладова", 'Гнойный']].freeze

  def initialize
    @rapers = Hash.new { |hash, key| hash[key] = [] }
  end

  def format_name(name)
    NAME_FORMAT_REGEXP.each do |pattern|
      name.sub!(Regexp.new(pattern.first, Regexp::IGNORECASE), pattern.last)
    end
    name
  end

  def read_files
    Dir.foreach('./rap-battles') do |file|
      next if File.directory?(file)
      @name = file.split(/против|aka|vs\b/i).first.strip
      open(file)
    end
    @rapers
  end

  def open(file)
    File.open("./rap-battles/#{file}") do |file_name|
      lines = file_name.readlines
      split_name(lines)
    end
  end

  def split_name(lines)
    lines.reject!(&:blank?)
    lines.map! { |line| line.scan(/[[A-яё]\*\'[A-яё]*\d]+/) }
    @rapers[format_name(@name)] << lines.flatten.join(' ').downcase
  end
end
