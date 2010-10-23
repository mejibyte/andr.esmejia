require 'spec_helper'

describe Comment do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :email => "value for email",
      :ip => "value for ip",
      :url => "value for url",
      :body => "value for body",
      :post => Factory(:post)
    }
  end

  it "should create a new instance given valid attributes" do
    Comment.create!(@valid_attributes)
  end
end
