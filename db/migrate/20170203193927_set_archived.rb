class SetArchived < ActiveRecord::Migration
  def change
  

    CallingScript.find_each do |script|
      script.archived ||= false
      script.save!
    end
  
  
  end
end
