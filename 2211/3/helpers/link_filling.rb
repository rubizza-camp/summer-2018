require 'ohm'
require 'sinatra'
require 'redis'
require 'mechanize'
require 'net/https'
require 'uri'
require 'json'
require_relative 'avr'

# Fill info about article and comments

class LinkFilling
  def initialize(response, documents, all_comments_texts, link)
    @response = response.body
    @documents = documents
    @all_comments_texts = all_comments_texts
    @link = link
  end

  def all_comments_rates
    response = JSON(@response)
    response['documents'].map { |elem| elem['score'] }
  end

  def filling
    new_link = Link.create(address: @link.to_s, rate: Avr.new(all_comments_rates).avr.to_s)
    @all_comments_texts.each_with_index do |com, index|
      new_link.comments.push(Comment.create(text: com, rate: comment_rate_calculate(index).to_s))
    end
  end

  def comment_rate_calculate(index)
    response = JSON(@response)
    response['documents'][index]['score'] * 200 - 100
  end
end
