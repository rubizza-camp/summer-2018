require_relative 'ParticipantsStorage'
# :reek:FeatureEnvy
# :reek:NestedIterators
# :reek:UtilityFunction
# :reek:TooManyStatements

# PopularWords find most popular words
class PopularWords
  def hash_all_words(name)
    ParticipantsStorage.new.battles_by_name(name)
                       .each_with_object(Hash.new(0)) do |word, word_count|
      File.open("Rapbattle/#{word}", 'r').each_line do |line|
        next if line["/Раунд \d/i"]
        line.split(' ').select { |each_word| wort_test(each_word) }
            .select do |term|
          word_count[term] += 1
        end
      end
    end
  end

  def prepare_hash(raper_name)
    hash = hash_all_words(raper_name).keys.join(' ')
                                     .downcase
                                     .gsub(/[.,!?:;«»<>&'()] /, ' ')
                                     .split
    hash.each_with_object(Hash.new(0)) do |word, word_count|
      word_count[word] += 1
    end
  end

  def sort_hash(raper_name)
    prepare_hash(raper_name).sort_by { |_, count| count }
  end

  def wort_test(word)
    !File.open('Предлоги.yaml', 'r', &:read).include?(word)
  end
end
