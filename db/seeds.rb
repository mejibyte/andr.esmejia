# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Post.destroy_all
%w(Chicago Copenhagen Paris).each do |city|
  Post.create(:title => "I'm going to #{city}", :body => "I'm very excited. I'm traveling next week to *#{city}*.\nTalk to you from there!")
end
Post.create(:title => "This is a very short post with an unbelievably long title. It was written mainly for testing purposes. When you think about it, it has more than two hundred and fifty five characters. How long can a title be? This is definetely the longest title I've written. In fact, it has 308 characters. Isn't that cool?", :body => "I told you!")

