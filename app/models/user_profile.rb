class UserProfile < ActiveRecord::Base
  validates :name, :presence => true, :length => { :maximum => 255 }
  validates :postcode, :presence => true, :length => { :is => 5 }, :numericality => true
  validates :gender, :inclusion => { :in => %w(M F), :allow_nil => true, :allow_blank => true }
  
  belongs_to :user
  has_one :photo, :as => :photoable, :class_name => 'ProfilePhoto', :dependent => :destroy
  
  validate do
    if postcode[0,3] == '750' && city.downcase != 'paris'
      errors.add(:city, I18n.t('activerecord.errors.models.merchant.attributes.city.does_not_match_postcode'))
    end
  end
  
  before_validation do
    self.city = 'Paris' if postcode[0,3] == '750' && city.blank?
  end
end