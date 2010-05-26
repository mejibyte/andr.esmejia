require 'spec_helper'

describe TwitterHelper do
  describe "auto_link_with_twitter" do
    it "should replace @user with a link to that user's Twitter page" do
      helper.auto_link_with_twitter("@andmej").should == '<a href="http://twitter.com/andmej">@andmej</a>'
    end

    it "should replace several @users with their links" do
      helper.auto_link_with_twitter("@nhocki: I don't know, ask @febuiles").
      should ==
      '<a href="http://twitter.com/nhocki">@nhocki</a>: I don\'t know, ask <a href="http://twitter.com/febuiles">@febuiles</a>'
    end

    it "should link normal URLs too" do
      helper.auto_link_with_twitter("This is cool: http://bit.ly/cWgEix (via @saritaja)").
      should ==
      'This is cool: <a href="http://bit.ly/cWgEix">http://bit.ly/cWgEix</a> (via <a href="http://twitter.com/saritaja">@saritaja</a>)'
    end
  end
end
