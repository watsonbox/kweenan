class UserProfile < ActiveRecord::Base
  validates_presence_of :name, :address, :city, :postcode
  validate :gender, :presence => true, :in => %w(M F)
  
  belongs_to :user
end