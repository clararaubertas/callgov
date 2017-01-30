class AddMostRecentToCallingScripts < ActiveRecord::Migration

  def change
    add_column :calling_scripts, :most_recent, :timestamp
  end

end
