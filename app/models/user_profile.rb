class UserProfile < ActiveRecord::Base
  validates :name, :presence => true, :length => { :maximum => 255 }
  validates :postcode, :presence => true, :length => { :is => 5 }, :numericality => true
  validates :gender, :inclusion => { :in => %w(M F), :allow_nil => true, :allow_blank => true }
  
  belongs_to :user
end