require_relative './text_analytics.rb'

# This class describes comment
class Comment
  attr_reader :text, :rate

  def initialize(text)
    @text = text
    docs = { 'id' => 1,
             'language' => 'ru',
             'text' => text }
    documents = { 'documents': [docs] }
    @rate = (TextAnalytics.new(documents).analyze['documents'][0]['score'] * 200 - 100).to_i
  end
end
