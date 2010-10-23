class Post < ActiveRecord::Base
  validates_presence_of :title, :body
  default_scope :order => "created_at DESC"
  named_scope :recent, :limit => 3 
  named_scope :published, :conditions => ["published_at <= ?", Time.zone.now]
  has_many :comments, :dependent => :destroy
  
  
  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end
end
