class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :terms, :acceptance => { :allow_nil => false, :message => 'user.terms.accepted' }, :on => :create, :if => lambda { |c| c.type == 'Customer' }

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :merchant_id, :type, :merchant, :terms
  
  belongs_to :merchant
  has_one :profile, :class_name => 'UserProfile'
end