class OnlinerApiHandler
  def handle_data(data)
    JSON(data)['comments'].each_with_index.map do |value, index|
      { id: index + 1, text: value['text'], author: value['author']['name'] }
    end
  end
end