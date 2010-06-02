class Post < ActiveRecord::Base
  validates_presence_of :title, :body
  default_scope :order => "created_at DESC"
  named_scope :recent, :limit => 3 
  has_many :comments, :dependent => :destroy
end
