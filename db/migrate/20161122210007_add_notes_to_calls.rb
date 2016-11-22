class AddNotesToCalls < ActiveRecord::Migration
  def change
    add_column :calling_scripts, :notes, :text
  end
end
