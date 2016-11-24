class CallingScript < ActiveRecord::Base
  validates_presence_of :content, :topic, :user, :summary
  belongs_to :user
  has_many :calls
  delegate :profile, :to => :user, :prefix => true
  delegate :picture, :to => :user, :prefix => true
  delegate :provider, :to => :user, :prefix => true

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders] 

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      [:topic, :summary],
      [:topic, :summary, :content]
    ]
  end
  

  def called_yet?(calling_user, ip, rep_id = nil)
    uid = calling_user.try(:id) || ip
    if rep_id
      Call.find_by_calling_script_id_and_user_id_and_rep_id(id, uid, rep_id).present?
    else
      Call.find_by_calling_script_id_and_user_id(id, uid).present?
    end
  end

  def record_call(rep_id, user_id)
    Call.find_or_create_by(:rep_id => rep_id, :calling_script_id => self.id, :user_id => user_id)
  end
  
end
