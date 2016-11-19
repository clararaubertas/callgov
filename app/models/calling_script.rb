class CallingScript < ActiveRecord::Base
  validates_presence_of :content, :topic, :user, :summary
  belongs_to :user
  has_many :calls

  def called_yet?(calling_user, ip)
    Call.find_by_calling_script_id_and_user_id(id, (calling_user.try(:id) || ip)).present?
  end
  
end
