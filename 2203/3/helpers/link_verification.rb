# This class check it's link correct or ha-ha, but no
class LinkVerificator
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def check_link
    error_message = 'Прости, братишка. Твоя ссылка корявая как моя жизнь.' unless link.include? 'https://tech.onliner.by/'
    error_message
  end
end
