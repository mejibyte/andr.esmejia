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
end
