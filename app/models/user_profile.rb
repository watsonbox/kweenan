class UserProfile < ActiveRecord::Base
  validates_presence_of :name, :gender, :address, :city, :postcode
  validates_inclusion_of :gender, :in => %w(M F)
  
  belongs_to :user
end