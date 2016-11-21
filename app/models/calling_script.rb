class CallingScript < ActiveRecord::Base
  validates_presence_of :content, :topic, :user, :summary
  belongs_to :user
  has_many :calls

  def called_yet?(calling_user, ip)
    Call.find_by_calling_script_id_and_user_id(id, (calling_user.try(:id) || ip)).present?
  end

  def record_call(rep_id, user_id)
    Call.find_or_create_by(:rep_id => rep_id, :calling_script_id => self.id, :user_id => user_id)
  end
  
end
