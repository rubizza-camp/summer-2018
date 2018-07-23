# BattleParser class
class TextsParser
  def initialize
    @hash = Hash.new { |key, value| key[value] = [] }
  end

  def self.name_split(file)
    file.split(/(против|VS|vs)/)[0].strip
  end

  def self.json_file_create(hash)
    File.open('data.json', 'w') { |file| file.puts hash.to_json }
  end

  def data_json_parse
    Dir.foreach(File.join(Dir.pwd, 'rap-battles')).each do |file|
      file_name = 'rap-battles/' + file
      next unless file.strip =~ /^[\w[а-яА-Я]]/
      @hash[TextsParser.name_split(file)] << File.read(file_name).tr!("\n", '')
    end
    TextsParser.json_file_create(@hash)
  end
end
