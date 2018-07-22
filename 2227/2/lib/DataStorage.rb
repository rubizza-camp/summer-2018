# Data storage with battles
class DataStorage
  def initialize
    @battles = Dir.glob('rap-battles2/*')
    @battles_of_rappers = battles_of_rappers
  end

  def find_names_of_the_rappers
    all_rappers = @battles_of_rappers.each_with_object([]) do |(file, _text), names|
      names << file.split(/(против | vs)/i).first
    end
    all_rappers.map(&:strip).uniq
  end

  def battles_of_rappers
    @battles.each_with_object({}) do |file, text|
      file_name = file.split(%r{^(rap-battles2/){1}.*?})[2]
      text[file_name] = File.read(file)
      text
    end
  end

  def find_all_battles(name)
    @battles_of_rappers.select { |file_name| file_name.match(/^#{name}/) }
  end
end
