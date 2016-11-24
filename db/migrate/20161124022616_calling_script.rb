class CallingScript < ActiveRecord::Migration
  def change
    add_column :calling_scripts, :slug, :string
    add_index :calling_scripts, :slug, unique: true
  end
end
