class Post < ActiveRecord::Base
  validates_presence_of :title, :body
  named_scope :recent, :order => "created_at DESC", :limit => 3 
end
