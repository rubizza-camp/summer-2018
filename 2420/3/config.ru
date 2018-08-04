require 'sinatra/base'
require 'ohm'

Dir.glob('./{helpers,controllers}/*.rb').each do |file|
  require file
end

map('/') { run ApplicationController }
map('/table') { run TableController }
map('/analysis') { run AnalysisController }
