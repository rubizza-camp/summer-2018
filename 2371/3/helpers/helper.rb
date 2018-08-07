class Helper
  def initialize(attr = {})
    attr.each { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
  end

  def to_json(_options)
    raise NotImplementedError
  end
end