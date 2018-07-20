require_relative 'author'
# The ContentManager responsible for searching authors info in files
class ContentManager
  def initialize
    @authors = []
  end

  def handle_files(files)
    raise 'No authors found' unless files.any?
    files.each do |file_name|
      author_from_battle_file_name(file_name) if File.file?("./texts/#{file_name}")
    end
  end

  def author_favorite_words_info(select, name)
    puts [select, name].to_s
  end

  def authors_bad_words_info
    raise 'No authors found' unless @authors.any?
    sort = @authors.sort_by! { |author| -author.bad_words.size }
    sort.map(&:to_print)
  end

  private

  def author_from_battle_file_name(battle_file_name)
    author_name = battle_file_name[NAMES_REGEX].strip.downcase
    add_battle_to_author(Author.new(author_name), Battle.new(battle_file_name))
  end

  def add_battle_to_author(new_author, battle)
    unless @authors.detect do |author|
      next unless author.name?(new_author.name)
      author.add_battle(battle)
      break author
    end
      new_author.add_battle(battle)
      @authors << new_author
    end
  end
end
