class Carrying < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :brand
end