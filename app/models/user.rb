class User < ActiveRecord::Base
  rolify
  after_create :add_user_role
  has_one :userprofile,:dependent=>:destroy
  # rolify :before_add => :before_add_method
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:add1, :callsign, :class_user, :efdate, :expdate, :fname, :lname, :state, :zip, :addr2, :city
  # attr_accessible :title, :body
  has_many :has_many, dependent: :destroy
  # def before_add_method(role)
  #   self.add_role :admin
  # 
  validates_presence_of :email,:password_confirmation,:password
  # accept_nested_attributes :userprofile
  def add_user_role
  	self.add_role :user
  end
  def is_admin
    if self.has_role?(:admin)
      "<input type='checkbox' id='#{self.id}' class='is_admin' checked=checked/>".html_safe
    else
      "<input type='checkbox' id='#{self.id}' class='is_admin'/>".html_safe
    end
  end
  def is_member
    if self.has_role?(:member)
      "<input type='checkbox' id='#{self.id}' class='is_member' checked=checked/>".html_safe
    else
      "<input type='checkbox' id='#{self.id}' class='is_member'/>".html_safe
    end
  end
  def is_voting_member
    if self.has_role?(:voting_member)
      "<input type='checkbox' id='#{self.id}' class='is_voting_member' checked=checked/>".html_safe
    else
      "<input type='checkbox' id='#{self.id}' class='is_voting_member'/>".html_safe
    end
  end
end
