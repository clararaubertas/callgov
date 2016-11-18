class AddUserToScripts < ActiveRecord::Migration
  def change
    add_column :calling_scripts, :user_id, :int
  end
end
