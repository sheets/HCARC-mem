class Userprofile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :add1, :callsign, :class_user, :efdate, :expdate, :fname, :lname, :state, :zip,:avatar,:remote_avatar_url
  validates :add1, :callsign, :class_user, :efdate, :expdate, :fname, :lname, :state, :zip, presence: true
  mount_uploader :avatar, AvatarUploader
end
