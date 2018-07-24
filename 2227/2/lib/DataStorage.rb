# Data storage with battles
class DataStorage
  PATH_OF_THE_FOLDER = 'rap-battles2/*'.freeze
  REGEXP_PATH = %r{^(rap-battles2/){1}.*?}

  def initialize
    @battles = Dir.glob(PATH_OF_THE_FOLDER)
  end

  def find_names_of_the_rappers
    all_rappers = @battles.each_with_object([]) do |(file, _text), names|
      names << file.split(REGEXP_PATH)[2].split(/(против | vs)/i).first
    end
    all_rappers.map(&:strip).uniq
  end

  def find_all_battles(name)
    @battles.each_with_object([]) do |file, text|
      file_name = file.split(REGEXP_PATH)[2]
      text << File.read(file) if file_name.match?(/^#{name}/)
    end
  end
end
