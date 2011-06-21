class Merchant < ActiveRecord::Base
  before_save :mark_business_hours_for_removal
  
  attr_accessible :name, :address, :city, :postcode, :phone, :hours, :description, :business_category_id, :brand_tokens, :business_hours_attributes
  validates_presence_of :business_category
  validates_associated :business_hours
  validates :name, :presence => true, :length => { :maximum => 128 }
  validates :address, :presence => true, :length => { :maximum => 255 }
  validates :city, :presence => true, :length => { :maximum => 64 }
  validates :postcode, :presence => true, :length => { :is => 5 }, :numericality => true
  
  has_one :user
  belongs_to :business_category
  has_many :carryings, :dependent => :destroy
  has_many :brands, :through => :carryings
  has_many :photos, :as => :photoable, :class_name => 'MerchantPhoto', :dependent => :destroy
  has_many :business_hours, :dependent => :destroy
  
  accepts_nested_attributes_for :business_hours, :allow_destroy => true
  attr_reader :brand_tokens
  
  validate do
    if postcode[0,3] == '750' && city.downcase != 'paris'
      errors.add(:city, I18n.t('activerecord.errors.models.merchant.attributes.city.does_not_match_postcode'))
    end
  end
  
  def filled_business_hours
    @filled_business_hours ||= [1,2,3,4,5,6,0].collect do |i|
      business_hours.select { |h| h.day == i }.first || BusinessHour.new(:day => i)
    end
  end
  
  def brand_tokens=(ids)
    self.brand_ids = ids.split(",")
  end
  
  def full_address
    [address, city, postcode].compact.join(', ')
  end
  
  def to_s
    name
  end
  
  protected

  def mark_business_hours_for_removal
    business_hours.each do |hour|
      hour.mark_for_destruction if hour.start_time.nil?
    end
  end
end