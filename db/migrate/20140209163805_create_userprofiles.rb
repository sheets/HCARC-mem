class CreateUserprofiles < ActiveRecord::Migration
  def change
    create_table :userprofiles do |t|
      t.string :callsign
      t.string :fname
      t.string :lname
      t.text :add1
      t.string :state
      t.string :zip
      t.string :class_user
      t.date :efdate
      t.date :expdate
      t.references :user

      t.timestamps
    end
    add_index :userprofiles, :user_id
  end
end
