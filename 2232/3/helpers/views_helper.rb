module ViewsHelper
  def show_article(article_id)
    "/articles/#{article_id}"
  end

  def new_article
    '/articles/new'
  end
end
