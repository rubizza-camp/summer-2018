class AzureApiHandler
  def handle_data(data)
    JSON(data)['documents']
  end
end