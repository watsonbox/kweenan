class Photo < ActiveRecord::Base
  belongs_to :merchant
  has_attached_file :data, :styles => { :small => "200x200#", :thumb => "100x100#" }
  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 5.megabytes
end