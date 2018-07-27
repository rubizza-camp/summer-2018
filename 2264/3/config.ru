Bundler.require
Dir.glob('./{controllers,helpers,models}/*.rb').sort.each { |file| require file }

map('/') { run PostsController }