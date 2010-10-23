require 'spec_helper'

describe Post do
  it "should create a valid instance from the Factory" do
    Factory.create(:post).should be_valid
  end
  
  %w(title body).each do |attr|
    it "should validate presence of #{attr}" do
      p = Post.new
      p.should have(1).error_on(attr)
    end
  end
  
  describe "published posts namespace" do
    it "should only include posts that where published before now" do
      post = Factory.create(:post)
      
      post.update_attributes!(:published_at => nil)
      Post.published.all.should_not include post
      
      post.update_attributes!(:published_at => 5.minutes.from_now)
      Post.published.all.should_not include post
      
      post.update_attributes!(:published_at => 5.minutes.ago)
      Post.published.all.should include post      
    end
  end
end
