require 'ohm'

class Comment < Ohm::Model
  attribute :body
  attribute :rating
end

class Article < Ohm::Model
  list :comments, :Comment
  attribute :link
  attribute :rating
end

 Ohm.redis.call("FLUSHALL")

onl = Article.create(:link => "https/blablabla", :rating => "0.8989")
first = Comment.create(:body => "com1", :rating => "0.111111")
second = Comment.create(:body => "com2", :rating => "0.222222")
onl.comments.push(first)
onl.comments.push(second)


obj = Article.fetch([1])
p obj[0].comments.range(0, 1).map(&:body)
p obj[0].link
p obj[0].rating








=begin

class LinksDataBase < Ohm::Model
	track :link

	def initialize(object)
		@object = object if check_object(object
	end
		

	def add(link)
		@object.call("RPUSH", "links", link)
	end

	def all
		@object.call("LRANGE", "links", 0, -1)
	end

	def cleardb
		@object.call("FLUSHALL")
	end

	private

	def check_object(object)
		object.is_a?(Redic) ? @object = object : raise()
	end
end


def add_entry(link, comments,)
  redis.call("RPUSH", , link)
end

def all
  redis.call("LRANGE", key[:links], 0, -1)
end

def flush
  @object.call("FLUSHALL")
end




log = Log.create
log.add("hello")
p log.all
log.add("world")
p log.all

=end