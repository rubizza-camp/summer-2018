# Data storage with battles
class DataStorage
  def self.find_names_of_the_rappers
    all_rappers = battles_of_rappers.each_with_object([]) do |(file, _text), names|
      names << file.split(/(против | vs)/i).first
    end
    all_rappers.map(&:strip).uniq
  end

  def self.battles_of_rappers
    Dir.glob('rap-battles2/*').each_with_object({}) do |file, text|
      file_name = file.split(%r{^(rap-battles2/){1}.*?})[2]
      text[file_name] = File.read(file)
      text
    end
  end

  def self.find_all_battles(name)
    battles_of_rappers.select { |file_name| file_name.match(/^#{name}/) }
  end
end
