class CreateCallingScripts < ActiveRecord::Migration
  def change
    create_table :calling_scripts do |t|
      t.text :content
      t.string :topic

      t.timestamps null: false
    end
  end
end
