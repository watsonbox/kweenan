class Merchant < ActiveRecord::Base
  attr_accessible :name, :address, :city, :postcode, :phone, :hours, :description, :business_category_id, :brand_tokens
  validates_presence_of :business_category
  validates :name, :presence => true, :length => { :maximum => 128 }
  validates :address, :presence => true, :length => { :maximum => 255 }
  validates :city, :presence => true, :length => { :maximum => 64 }
  validates :postcode, :presence => true, :length => { :is => 5 }, :numericality => true
  
  has_one :user
  belongs_to :business_category
  has_many :carryings, :dependent => :destroy
  has_many :brands, :through => :carryings
  has_many :photos, :dependent => :destroy
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