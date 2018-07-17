require 'russian_obscenity/base'

# 1st task
# :reek:UtilityFunction
class TopBadWords
  attr_reader :number
  def initialize(number)
    Dir.chdir('versus-battle')
    @number = number
  end

  def print_top
    top_members_by_bad_words.each do |member|
      output(member)
      puts
    end
  end

  def output(member)
    printf('%-25s ', member.name)
    printf('| %-2d battles ', member.battles)
    printf('| %-4d  total bad words ', member.bad_words)
    printf('| %-3.2f  bad words per battle ', member.avr_words)
    printf('| %-4d  words per round', member.words_per_round)
  end

  def top_members_by_bad_words
    member_by_bad_words.first(number)
  end

  def member_by_bad_words
    members.sort_by { :bad_words }.reverse
  end

  def members
    raw_data = Reader.new.add_data
    raw_data.map { |name, texts| Member.new(name, texts) }
  end

  def raw_data
    Reader.new.add_data
  end
end

# Member Initialize
# :reek:UtilityFunction
class Member
  attr_reader :name
  def initialize(name, texts)
    @name = name
    @texts = texts
  end

  def battles
    @texts.size
  end

  def bad_words
    BadWordsCounter.new(@texts).counter
  end

  def avr_words
    bad_words / battles
  end

  def all_words_counter(total_count = 0)
    @texts.each do |text|
      total_count += line_size(text)
    end
    total_count
  end

  def line_size(text)
    text.scan(/[A-zА-я]+/).size
  end

  def words_per_round
    all_words_counter / rounds_counter
  end

  def rounds_counter
    RoundsCounter.new(@texts).file_read
  end
end

# Bad Words Count
class BadWordsCounter
  def initialize(texts)
    @texts = texts
    @count = 0
  end

  def counter
    @texts.each do |text|
      @count += RussianObscenity.find(text).size
    end
    @count
  end
end

# countes battles number
class RoundsCounter
  def initialize(texts, count = 0)
    @texts = texts
    @count = count
  end

  def file_read
    @texts.each do |text|
      find_rounds(text)
    end
    @count
  end

  def find_rounds(text, count = 0)
    text.each_line do |line|
      count += 1 if /^(Р|р)аунд \d/ =~ line
    end
    extra if count.zero?
    @count += count
  end

  def extra
    @count += 1
  end
end

# Read a file
# :reek:UtilityFunction
class Reader
  def initialize
    @members = {}
  end

  def add_data
    files.each do |file|
      @members[file.member_name] ||= []
      @members[file.member_name] << file.text
    end
    @members
  end

  def files
    all_files_names.map do |file_name|
      NewFile.new(file_name)
    end
  end

  def all_files_names
    Dir.glob('*')
  end
end

# choose rapper's name
class NewFile
  def initialize(file_name)
    @file_name = file_name
  end

  def member_name
    @file_name.chomp(tail_for_delete)
  end

  def tail_for_delete
    @file_name[/\s{1}(против|vs|VS){1}\s{1}.+\z/]
  end

  def text
    File.read(@file_name)
  end
end
