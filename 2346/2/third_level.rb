class Analysis
  def self.third_level
    all_paths = find_files
    rhymes_from_all_battles = []
    all_paths.each { |path| rhymes_from_all_battles << Plagiat.search_rhymes(path.to_s) }
    Plagiat.print(rhymes_from_all_battles)
  end
end

class Plagiat
  def self.search_rhymes(file_name)
    rhymes_in_battle = Rhymes.new(file_name)
    words = last_words_in_lines(file_name)
    rhymes_in_battle.make_rhymes_from_words(words)
    rhymes_in_battle
  end

  def self.print(rhymes_objects)
    rhymes_objects.each do |rhyme_current|
      rhymes_pairs_list = rhyme_current.all_rhymes_pairs_excluding_self(rhymes_objects)
      rhymes_plagiat = rhyme_current.rhymes & rhymes_pairs_list
      print_plagiat(rhyme_current.battle, rhymes_plagiat)
    end
  end

  def self.print_plagiat(current, res)
    puts current
    puts !res.empty? ? res : 'НЕТ ПЛАГИАТА'
    puts
  end

  def self.last_words_in_lines(file)
    words_maybe_rhymes = []
    IO.foreach(file) do |line|
      words_maybe_rhymes << last_words_filter(line)
    end
    words_maybe_rhymes.compact
  end

  def self.last_words_filter(line)
    words = line.downcase.scan(/[ёа-яa-z\*]+/)
    words.delete('quot')
    words.last
  end
end

# :reek:FeatureEnvy
class Rhymes
  attr_reader :rhymes, :battle

  def initialize(file_name)
    @rhymes = []
    @battle = file_name
  end

  # :reek:TooManyStatements
  def make_rhymes_from_words(words)
    words.each_index do |ind|
      one_part_of_rhyme = words[ind]
      next_inds = ind + 1
      while next_inds < words.size && next_inds <= ind + 4
        rhymes << one_part_of_rhyme + ' - ' + words[next_inds]
        next_inds += 1
      end
    end
    rhymes.uniq!
  end

  def all_rhymes_pairs_excluding_self(rhymes_objects)
    rhymes_pairs_list = []
    rhymes_objects.each do |rhyme_object|
      rhymes_pairs_list << rhyme_object.rhymes if rhyme_object != self
    end
    rhymes_pairs_list.flatten
  end
end
