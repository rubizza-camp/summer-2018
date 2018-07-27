require_relative 'scraper.rb'

# Comment object contains message and rating
class OnlinerComment
  attr_reader :message, :rating
  def initialize(message, rating)
    @message = message
    @rating = rating
  end
end

# Forms an array of objects with message and rating
class Analyze
  LIMIT = 50
  def initialize
    @comments = JSONParser.new.comments_options
    @array = []
  end

  def sort_array_of_objects
    array_of_objects.sort_by! { |obj| -obj.rating }.take(LIMIT)
  end

  private

  def array_of_objects
    @comments.each do |variable|
      @array << OnlinerComment.new(variable['text'], Helper.rating(variable['marks']))
    end
    @array
  end
end
