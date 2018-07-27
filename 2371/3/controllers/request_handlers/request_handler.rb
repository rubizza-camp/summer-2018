# The RequestHandler responsible for making request on api
class RequestHandler
  attr_reader :args
  def initialize(args)
    @args = args
  end

  def make_request(_data_handler)
    raise NotImplementedError
  end
end