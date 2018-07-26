module CommentHelper
  def self.votes(options)
    options['marks'].values.reduce(:+)
  end

  def self.author(options)
    options['author']['name']
  end

  def self.text(options)
    options['text']
  end
end
