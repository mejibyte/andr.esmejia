# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def tweet_url(author, tweet_id)
    "http://twitter.com/#{author}/statuses/#{tweet_id}"
  end
end
