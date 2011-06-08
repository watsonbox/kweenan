class Merchant < ActiveRecord::Base
  validates_presence_of :name, :address, :city, :postcode, :business_category_id
  belongs_to :user
  belongs_to :business_category
  
  def full_address
    [address, city, postcode].compact.join(', ')
  end
  
  def to_s
    name
  end
end