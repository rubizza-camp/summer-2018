# Class present new table in console
class TablePresenter
  attr_reader :header, :row

  def initialize(headers, rows)
    @header = headers
    @rows   = rows
  end
end
