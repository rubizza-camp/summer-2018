# Module for help
module Helper
  PRONOUNS = YAML.load_file('config.yml')['PRONOUNS_ARRAY'].join('|')

  def duplicates_counter(array_storage)
    array_storage.each_with_object(Hash.new(0)) { |word, counts| counts[word] += 1 }
  end

  def delete_pronouns(array_storage)
    array_storage.delete_if { |elem| elem.downcase.match(/#{PRONOUNS}/) }.map!(&:capitalize)
  end

  module_function :duplicates_counter, :delete_pronouns
end
