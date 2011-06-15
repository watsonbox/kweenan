class UserProfile < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :postcode
  validates :postcode, :length => { :is => 5 }, :numericality => true
  validates :gender, :presence => true, :inclusion => %w(M F)
  
  belongs_to :user
end