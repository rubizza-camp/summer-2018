require 'mechanize'

agent = Mechanize.new
page  = agent.get('https://people.onliner.by/2018/07/23/vodol')

# reviews = review_links.map do |link|
  # review = page.click
  review_meta = review.search('#main .review-meta .info')
  artist = review_meta.search('h1')[0].text
  album = review_meta.search('h2')[0].text
  label, year = review_meta.search('h3')[0].text.split(';').map(&:strip)
  reviewer = review_meta.search('h4 address')[0].text
  review_date = Date.parse(review_meta.search('.pub-date')[0].text)
  score = review_meta.search('.score').text.to_f
  {
    artist: artist,
    album: album,
    label: label,
    year: year,
    reviewer: reviewer,
    review_date: review_date,
    score: score
  }
# end

puts JSON.pretty_generate(reviews)