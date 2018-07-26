# Reader class with two attrs
class Reader
  attr_reader :content, :result

  def initialize(data)
    @data = data
    @result = []
  end

  def read
    @data.each do |array|
      battles_stats_array(array)
    end
    @result
  end

  def battles_stats_array(_array)
    raise NotImplementedError
  end
end
