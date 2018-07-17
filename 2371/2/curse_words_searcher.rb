require 'terminal-table'
require File.expand_path(File.dirname(__FILE__) + '/reg_ex_const')
# The AuthorObject responsible for saving author info
class Author
  attr_reader :author_name
  attr_reader :curse_words

  def initialize(author, battle_name)
    @author_name = author
    @battles = []
    @curse_words = []
    @words_per_battle = 0
    add_battle(battle_name)
  end

  def add_battle(battle_file_name)
    @battles << battle_file_name
    manage_battle_text(File.read("./texts/#{battle_file_name}"))
  end

  def print_info
    b_size = @battles.size
    c_size = @curse_words.size
    [author_name,
     "#{b_size} батлов",
     "#{c_size} нецензурных слов",
     "#{format('%.2f',
               (c_size.to_f / b_size))} слова на баттл",
     "#{@words_per_battle} слова в раунде"]
  end

  private

  def manage_battle_text(text)
    @curse_words += text.scan(CURSE_WORDS_REGEX)
    rounds = text.scan(/Раунд\s?\d+?/i)
    @words_per_battle += format('%.2f', text.split(' ').size /
        (rounds.any? ? rounds.size : 1)).to_f
  end
end

# The CurseWordsSearcher responsible for searching authors info in files
class CurseWordsSearcher
  def initialize(rows)
    @thread = Thread.new do
      0.step(1000, 5) do |step|
        printf("\rSearching:  %-20s", '*' * (step / 5))
        sleep(0.5)
      end
    end
    @files_name = Dir.entries('./texts/').reject { |item| item =~ /^\./i }
    @authors = []
    @show_rows = rows.to_i
  end

  def start
    @files_name.each do |name|
      parse_battle_files(name)
    end
    show_info
  end

  def show_info
    @thread.kill
    @authors.sort_by! { |author| -author.curse_words.size }
    puts
    puts Terminal::Table.new rows: @authors.map(&:print_info)[0...@show_rows]
  end

  def parse_battle_files(file_name)
    author_name = file_name[NAMES_REGEX].strip.downcase
    unless @authors.detect do |author|
      name = author.author_name
      if name.include?(author_name) || author_name.include?(name)
        author.add_battle(file_name)
        break author
      end
    end
      @authors << Author.new(author_name, file_name)
    end
  end
end

if ARGV.empty?
  puts 'To start searching add command --top-bad-words=<<number_of_top>>'
elsif !ARGV[0][/\d+/]
  puts 'Write correct command "--top-bad-words=<<number_of_top>>"'
elsif ARGV.length != 1
  puts 'Too many arguments'
else
  begin
    @files_name = Dir.entries('./texts/').reject { |item| item =~ /^\./i }
    CurseWordsSearcher.new(ARGV[0][/\d+/]).start
  rescue StandardError => _e
    warn 'No battles files in directory "texts"!
Add battle files to "texts" folder'
  end
end
exit
