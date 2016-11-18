class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string :user_id
      t.string :calling_script_id
      t.string :rep_id

      t.timestamps null: false
    end
  end
end
