class LinkVerificator
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def check_link
    error_message = ''
    error_message = 'Invalid link. Please, enter another link.' unless link.include? 'https://tech.onliner.by/'
    error_message
  end
end
