class AddPinnedToScripts < ActiveRecord::Migration
  def change
    add_column :calling_scripts, :pinned, :boolean, :default => false
  end
end
