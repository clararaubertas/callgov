class AddSummaryToCallingScript < ActiveRecord::Migration
  def change
    add_column :calling_scripts, :summary, :text
  end
end
