module TwitterHelper
  def tweet_url(author, tweet_id)
    "http://twitter.com/#{author}/statuses/#{tweet_id}"
  end

  def auto_link_with_twitter(text, options = {})
    text = text.split(" ").collect do |word|
      word.gsub(/^@(\w*)/) { link_to("@" + $1, "http://twitter.com/" + $1) }
    end.join(" ")
    auto_link(text, options)
  end
end
