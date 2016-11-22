class AddCachedCount < ActiveRecord::Migration
  def change
    add_column :calling_scripts, :calls_count, :integer, default: 0
  end
end
