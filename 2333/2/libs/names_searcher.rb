class NamesSearcher
  def initialize(rappers, selected_name)
    @rappers = rappers
    @name = selected_name
  end

  def search_name
    names = rappers_names
    result = case names.include?(@name)
             when true
               true
             when false
               false
             end
    result
  end

  private

  def rappers_names
    names = []
    @rappers.each { |rapper| names << rapper.name }
    names
  end
end
