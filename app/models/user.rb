class User < ActiveRecord::Base
  rolify
  after_create :add_user_role
  has_one :userprofile
  # rolify :before_add => :before_add_method
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  accepts_nested_attributes_for :userprofile
  # def before_add_method(role)
  #   self.add_role :admin
  # end

  def add_user_role
  	self.add_role :user
  end
end