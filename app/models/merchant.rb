class Merchant < ActiveRecord::Base
  attr_accessible :name, :address, :city, :postcode, :phone, :email, :hours, :description, :business_category_id, :brand_tokens
  validates_presence_of :name, :address, :city, :postcode, :business_category_id
  has_one :user
  belongs_to :business_category
  has_many :carryings
  has_many :brands, :through => :carryings
  attr_reader :brand_tokens
  
  def brand_tokens=(ids)
    self.brand_ids = ids.split(",")
  end
  
  def full_address
    [address, city, postcode].compact.join(', ')
  end
  
  def to_s
    name
  end
end