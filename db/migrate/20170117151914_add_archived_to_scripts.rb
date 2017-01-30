class AddArchivedToScripts < ActiveRecord::Migration
  def change
    add_column :calling_scripts, :archived, :boolean
  end
end
