# This is class perform jobs in background
class PostWorker
  include Sidekiq::Worker
  def perform(link)
    call(link)
  end

  private

  def call(link)
    CreatePost.new(link).perform
  end
end
