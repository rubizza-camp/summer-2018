# :reek:FeatureEnvy
# :reek:NestedIterators
# :reek:UtilityFunction
# :reek:TooManyStatements
# :reek:IrresponsibleModule
# PopularWords
class PopularWords
  def hash_all_words(name)
    search_battles(name).each_with_object(Hash.new(0)) do |word, word_count|
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

  def search_battles(name)
    Dir.entries('Rapbattle/')
       .select { |files| /\b#{name} (против|vs)\b/i =~ files }
  end

  def wort_test(word)
    !File.open('Предлоги.txt', 'r', &:read).include?(word)
  end
end
