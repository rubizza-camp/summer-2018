require 'json'

class Parser
  attr_reader :hash

  def initialize
    @hash = Hash.new { |hash_, key| hash_[key] = { battles: [], obscene_words: 0, bad_words_on_battle: 0 } }
  end

  def write_data
    create_hash
    write_file
  end

  def read_data
    @hash = JSON.parse(File.read('data.json'))
  end

  private

  def create_hash
    Dir.foreach(File.join(File.expand_path(__dir__), 'rap-battles')).each do |file|
      next unless file.strip =~ /^[\w[A-я]]/
      @hash[rapper_name(file)][:battles] << File.read("rap-battles/#{file}").tr!("\n", ' ')
    end
    add_info
  end

  def add_info
    @hash.each do |rapper, data|
      bad_words = Helper.obscene_words(data[:battles])
      @hash[rapper][:obscene_words] = Helper.obscene_words(data[:battles])
      @hash[rapper][:bad_words_on_battle] = (bad_words.to_f / @hash[rapper][:battles].count).round(2)
    end
  end

  def rapper_name(file)
    file.split(/против|VS\b|vs\b/)[0].strip
  end

  def write_file
    File.open('data.json', 'w') { |file| file.puts @hash.to_json }
  end
end
