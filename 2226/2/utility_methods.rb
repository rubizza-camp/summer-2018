# This module is used for utility methods
module UtilityMethods
  PRONOUNS = YAML.load_file('config.yml')['PRONOUNS_ARRAY'].join('|')

  def self.count_all_duplicates(array_storage)
    array_storage.each_with_object(Hash.new(0)) { |word, counts| counts[word] += 1 }
  end

  def self.storage_for_all_text(name)
    DataStorage.show_all_data.inject('') do |string, (file_name, file_content)|
      string += file_content if file_name.match(name)
      string
    end
  end

  def self.the_most_used_words(top_words, name)
    array_storage = UtilityMethods.storage_for_all_text(name).gsub(/,|'/, ' ').split
    array_storage.delete_if { |elem| elem.downcase.match(/#{PRONOUNS}/) }.map!(&:capitalize)
    UtilityMethods.count_all_duplicates(array_storage).sort_by { |_, value| value }.reverse.to_h.first(top_words.to_i)
  end
end
