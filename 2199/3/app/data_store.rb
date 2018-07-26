# storage of data
class DataStore
  def initialize(page)
    @page = page
    @comments = {}
  end

  def add_comment_to_storage(comment)
    @comments << comment
  end
end