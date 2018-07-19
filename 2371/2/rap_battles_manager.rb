require 'terminal-table'
require File.expand_path(File.dirname(__FILE__) + '/author_entity')
require File.expand_path(File.dirname(__FILE__) + '/constants')

# The RapBattlesManager responsible for searching authors info in files
class RapBattlesManager
  def initialize
    @authors = []
  end

  def upload_battles_files(files)
    raise 'No files for parse' if files.empty?
    files.each do |name|
      file_parsing(name)
    end
  end

  def show_favorite_info(select, name)
    puts [select, name].to_s
  end

  def show_bad_words_info(select)
    raise 'Authors Files doesn\'t upload' unless @authors.any?
    @authors.sort_by! { |author| -author.battles_info[:curse_words] }
    puts Terminal::Table.new rows: \
@authors.map(&:bad_words_print)[0...select.to_i]
  end

  def file_parsing(file_name)
    author_name = file_name[NAMES_REGEX].strip.downcase
    unless @authors.detect do |author|
      name = author.author_name
      if name.include?(author_name) || author_name.include?(name)
        author.add_battle(file_name)
        break author
      end
    end
      @authors << AuthorEntity.new(author_name, file_name)
    end
  end
end
