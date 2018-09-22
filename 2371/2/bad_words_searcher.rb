require 'terminal-table'
# :nodoc:
# :reek:TooManyStatements
# :reek:NestedIterators
# :reek:DuplicateMethodCall
# :reek:InstanceVariableAssumption
# :reek:IrresponsibleModule
# :reek:FeatureEnvy
class BadWordsSearcher
  def initialize(rows)
    @thread = Thread.new do
      0.step(1000, 5) do |step|
        printf("\rSearching:  %-20s", '*' * (step / 5))
        sleep(0.5)
      end
    end
    @show_rows = rows
  end

  def top_bad_words
    search_bad_words
    @thread.kill
    rows = @authors_list.map do |author|
      [author[:author],
       author[:battles],
       author[:how_much],
       author[:words_per_battle]]
    end
    puts
    puts Terminal::Table.new rows: rows[0...@show_rows.to_i]
  end

  private

  def search_bad_words
    @battles_names = Dir.entries('./texts/').reject { |item| item =~ /^\./i }
    authors = @battles_names.map do |elem|
      elem[/^.+?(?='?(а|a|ы)?\s+(против|vs))/i].to_s.strip.downcase
    end.sort.uniq
    @authors_list = find_battles_per_author(authors)
    find_authors_bad_words
  end

  def find_battles_per_author(files)
    files.map! do |name|
      {
        author: name,
        files: @battles_names.select do |file_name|
                 file_name[/^.?#{Regexp.escape(name)}.+/i]
               end
      }
    end
  end

  # rubocop:disable AbcSize, MethodLength,FormatString
  def find_authors_bad_words
    @authors_list.each do |value|
      bad_words = value[:files].map do |file|
        File.read("./texts/#{file}").scan(Regexp.new(File.read('bad_words_regex')))
      end.flatten
      words_per_battle = '%.2f' % (bad_words.size.to_f / value[:files].size)
      value[:battles] = "#{value[:files].size} батлов"
      value[:bad_words] = bad_words.size
      value[:how_much] = "#{bad_words.size} нецензурных слов"
      value[:words_per_battle] = "#{words_per_battle} слова на баттл"
    end
    @authors_list = @authors_list.sort_by { |hsh| hsh[:bad_words] }.reverse
  end
  # rubocop:enable AbcSize, MethodLength, FormatString
end

if ARGV.empty?
  puts 'To start searching add command --top-bad-words=<<number_of_top>>'
elsif !ARGV[0][/\d+/]
  puts 'Write correct command "--top-bad-words=<<number_of_top>>"'
elsif ARGV.length != 1
  puts 'Too many arguments'
else
  BadWordsSearcher.new(ARGV[0][/\d+/]).top_bad_words
end
exit
