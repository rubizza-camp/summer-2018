class DataHandler
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def handle_data
    raise NotImplementedError
  end
end