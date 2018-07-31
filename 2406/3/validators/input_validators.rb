module Validators
  class InputValidators
    DOMAIN_NAME = 'onliner.by'.freeze

    def exist(article_list, link)
      raise ArgumentError if article_list.include?(link)
    end

    def invalid_link(link)
      raise ArgumentError unless link.include?(DOMAIN_NAME)
    end
  end
end
