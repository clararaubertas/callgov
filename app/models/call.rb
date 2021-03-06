# the Call class tracks calls that have been placed
class Call < ActiveRecord::Base
  belongs_to :user
  belongs_to :calling_script, counter_cache: true
  validates_presence_of :rep_id
  after_save :update_recent_call

  def update_recent_call
    calling_script.update_attribute(:most_recent, created_at)
  end
  
  def rep
    Legislator.all_where(:bioguide_id => rep_id).first
  end

  
end
