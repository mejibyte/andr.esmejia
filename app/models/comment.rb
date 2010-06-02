class Comment < ActiveRecord::Base
  validates_presence_of :name, :email, :ip, :body
  belongs_to :post
end
