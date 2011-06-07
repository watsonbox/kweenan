class Merchant < ActiveRecord::Base
  validates_presence_of :name, :address, :city, :postcode
  belongs_to :user
  
  def full_address
    [address, city, postcode].compact.join(', ')
  end
  
  def to_s
    name
  end
end