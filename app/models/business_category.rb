class BusinessCategory < ActiveRecord::Base
  validate :name, :unique => true, :present => true
  has_many :merchants
  
  default_scope :order => 'name'
  
  def to_s
    name
  end
end