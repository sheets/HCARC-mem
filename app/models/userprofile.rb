class Userprofile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :add1, :callsign, :class_user, :efdate, :expdate, :fname, :lname, :state, :zip
end
