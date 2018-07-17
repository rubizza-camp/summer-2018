require './battle'
require './raper'

class ObscenceRaper
  # This method smells of :reek:FeatureEnvy
  def the_most_obscene_rappers(quantity = nil)
    rap_objects = Raper.all
    quantity ||= rap_objects.size
    obj_sort = rap_objects.sort_by do |obj|
      1 - obj.bad_words.size
    end[0..(quantity - 1)]
    show_stats(obj_sort)
  end

  def show_stats(obj_raper)
    obj_raper.each { |obj| puts obj.show }
  end
end
