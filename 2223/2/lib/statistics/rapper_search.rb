module RapperSearch
  def rapper_by_name(rappers, name)
    rapper = rappers.find { |author| author.name == name }
    search_rapper_error(rappers, name) unless rapper
    rapper
  end

  def search_rapper_error(rappers, name)
    puts "Рэпер #{name} не известен мне. Зато мне известны:"
    puts rappers.map(&:name).sort
  end
end
