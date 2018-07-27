require_relative 'raper.rb'

# Class all rapers, collection of statistics
class AllRapers
  attr_reader :all_rapers, :sors_names
  def initialize
    @sors_names = []
    @names = []
    @all_rapers = []
  end

  LIST_ALL_BATTLES = Dir['rap-battles/*']

  def names
    LIST_ALL_BATTLES.each do |file|
      name = file.split(/ против | vs /i).first.split('/').last.strip
      @names.push(name)
    end
    @names.uniq!
  end

  def create_all_rapers
    names.each do |name|
      search = SearchBattles.new(name)
      search.count_battles
      @all_rapers.push(Raper.new(name, search.list))
    end
  end

  def bad_words
    @all_rapers.each { |raper| raper.bad_words}
  end

  def sorting
    @all_rapers.each { |raper| @sors_names.push([raper.bad_words, raper.name])}
    @sors_names.sort! { |first, last| last <=> first }
  end
end
