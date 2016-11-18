class AddProfileAndPictureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :string
    add_column :users, :picture, :string
  end
end
