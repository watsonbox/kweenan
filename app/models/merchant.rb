class Merchant < ActiveRecord::Base
  attr_accessible :name, :address, :city, :postcode, :phone, :hours, :description, :business_category_id, :brand_tokens, :business_hours_attributes, :closed_for_lunch
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
      business_hours.select { |h| h.day == i }.first || BusinessHour.new(
        :day => i,
        :start_time => i == 0 ? nil : '09:00',
        :end_time => i == 0 ? nil : '18:00'
      )
    end
  end
  
  def open_now?
    integer_time = (Time.now.hour * 60) + Time.now.min
    todays_hours = business_hours.all.find { |bh| bh.day == Date.today.wday }
    todays_hours.open? && (
      (todays_hours.attributes['start_time']..todays_hours.attributes['end_time']) === integer_time ||
      todays_hours.attributes['start_time2'].present? && (todays_hours.attributes['start_time2']..todays_hours.attributes['end_time2']) === integer_time
    )
  end
  
  attr_writer :closed_for_lunch
  def closed_for_lunch
    @closed_for_lunch == '1' || business_hours.any? { |bh| bh.start_time2.present? }
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
end