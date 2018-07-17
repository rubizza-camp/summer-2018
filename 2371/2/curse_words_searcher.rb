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
    return unless File.file?("./texts/#{battle_file_name}")
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

# The AuthorsInfoSearcher responsible for searching authors info in files
class AuthorsInfoSearcher
  def initialize(rows)
    @thread = Thread.new do
      0.step(1000, 5) do |step|
        printf("\rSearching:  %-20s", '*' * (step / 5))
        sleep(0.5)
      end
    end
    @authors = []
    @show_rows = rows.to_i
  end

  def search_info_in_files(files)
    files.each do |name|
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

# The Application responsible for checks params and start project
class Application
  def run
    return puts 'Not found "texts" directory' unless File.directory?('./texts/')
    return puts 'Argument to start search --top-bad-words=<<number>>' \
if ARGV.empty? || !ARGV[0][/=\d+$/i]
    return puts 'Too many arguments' if ARGV.length != 1
    manage
  end

  private

  def manage
    @searcher = AuthorsInfoSearcher.new(ARGV[0][/\d+/])
                                   .search_info_in_files(Dir.entries('./texts/')
                                      .reject { |item| item =~ /^\./i })
  end
end

Application.new.run
exit
