require_relative 'data_store'
class CommentsAnalyzer
  attr_reader :text

  def initialize(text)
    @text = text
  end

  def analyze(text)

    count_rating(rating)
  end

  def count_rating(rating)
    (rating * 2) - 100
  end
end

=begin
def parse_page(article)
  article = Nokogiri::HTML(open(article_url))
  comments = []
  comments << article.html()
end

def analyze_comment(comment)
  session = Capybara::Session.new(:selenium)
  session.visit('https://azure.microsoft.com/en-u¡¡s/services/cognitive-services/text-analytics/?v=18.05')
  session.fill_in('InputText', with: comment)
  session.click_button('Analyze')
end
=end