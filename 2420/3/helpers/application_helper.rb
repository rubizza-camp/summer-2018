# module ApplicationHelper
module ApplicationHelper
  def title(value = nil)
    @title = value if value
    @title || 'MyApp'
  end
end
