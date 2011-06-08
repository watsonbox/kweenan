class Brand < ActiveRecord::Base
  validate :name, :present => true, :unique => true
  
  has_many :carryings
  has_many :merchants, :through => :carryings
  
  def to_s
    name
  end
end