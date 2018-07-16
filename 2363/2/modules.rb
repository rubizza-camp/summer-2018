# My method that don't use instance state
module SomeMethods
  attr_reader :data
  def self.parse_name(file_name)
    name = file_name.split('/').last.split('(').first.split(/ против | vs | VS | & | && /).first.strip
    return name unless name == ''
    '(Pra(Killa\'Gramm)'
  end

  # This method smells of :reek:TooManyStatements
  def self.parse_data(file_name)
    File.open(file_name, 'r') do |file|
      text = file.read.split(/Раунд 1|Раунд 2|Раунд 3/)
      size = text.size
      words = text.join.downcase.split(/[, \.:?!\n\r]+/)
      @data = { words: words.size, bad_words: count_bad_words(words), rounds: size > 1 ? size - 1 : size }
    end
    @data
  end

  def self.count_bad_words(words)
    bad_words = 0
    words.each do |word|
      bad_words += 1 if word.include? '*'
    end
    bad_words += RussianObscenity.find(words.join(' ')).size
  end

  def self.compare_names(first, second)
    size = first.length > second.length ? first.size : second.size
    check_size = (0..(size - (size > 3 ? size / 3 : 0)))
    first[check_size].eql?(second[check_size])
  end
end
