class BusinessCategory < ActiveRecord::Base
  validate :name, :unique => true, :present => true
  has_many :merchants
  
  def to_s
    name
  end
end