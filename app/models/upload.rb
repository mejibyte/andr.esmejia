class Upload < ActiveRecord::Base
  has_attached_file :file, :styles => { :big => "600x600>", :medium => "300x300>", :thumb => "100x100>" }
end
