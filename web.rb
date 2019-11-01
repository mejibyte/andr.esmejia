require 'sinatra'

Encoding.default_external = 'UTF-8'

# Needed for Elastic Beanstalk (otherwise it can't find the views).
set :root, File.dirname(__FILE__)
set :views, Proc.new { File.join(root, "views") }

# Guide: https://devcenter.heroku.com/articles/getting-started-with-ruby-o#prerequisites
get '/' do
  erb :index
end

get '/robots.txt' do
  content_type :text
  "User-agent: *\nDisallow: /\n"
end
