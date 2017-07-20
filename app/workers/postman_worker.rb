class PostmanWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'mailers'
  def perform(*args)
    puts "Doing some work"
  end
end
