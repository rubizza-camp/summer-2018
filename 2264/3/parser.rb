require 'mechanize'
require 'json'

agent = Mechanize.new
page = agent.get('https://tech.onliner.by/2018/07/24/intel-26')

pp page.css('p').inner_html





