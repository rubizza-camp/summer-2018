# frozen_string_literal: true

require 'ohm'
require 'shotgun'
require 'sinatra'
require 'pry'
Dir.glob('./{controllers,helpers,models}/*.rb').sort.each { |file| require file }
Post.redis = Redic.new('redis://127.0.0.1:6379/0')
Comment.redis = Redic.new('redis://127.0.0.1:6379/1')

map('/') { run PostsController }
