# Class creates view of top word which uses selected Rapper
class TopWordView
  def self.write_to_console(word, value)
    puts word.capitalize + ' - ' + value.to_s
  end

  def self.write_to_console_rappers(rappers, rapper_name)
    puts "\nРэпер #{rapper_name} не судился. Осуждены следующие:\n\n"
    rappers.each { |_key, value| puts value.name }
  end
end
