require './battle'
require './raper'

# This method smells of :reek:TooManyStatements
class ObscenceRaper
  def self.the_most_obscene_rappers(quantity = nil)
    obj_rapers = Raper.all
    quantity ||= obj_rapers.size
    if obj_rapers.empty?
      puts 'Object empty or nil'
    else
      obj_sort = obj_rapers.sort_by do |obj|
        1 - obj.size_bad_words
      end[0..(quantity - 1)]
      obj_sort.each { |obj| puts obj.show }
    end
  end
end
