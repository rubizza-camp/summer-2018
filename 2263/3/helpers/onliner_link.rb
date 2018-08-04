# Link class
class OnlinerLink
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def verified?
    @link.match?(%r{https://tech.onliner.by/})
  end
end
