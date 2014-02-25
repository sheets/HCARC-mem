class AddAvatarToUserprofile < ActiveRecord::Migration
  def change
    add_column :userprofiles, :avatar, :string
  end
end
