class CallingScript < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_full_text, :against => [:content, :topic, :summary]
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

  def more_reps?(uid)
    Call.find(:all, conditions: { calling_script_id: id, user_id: uid}).size < 3
  end
  
  def called_this_rep?(uid, rep_id)
    Call.find_by_calling_script_id_and_user_id_and_rep_id(
      id,
      uid,
      rep_id
    ).present?
  end      

  def called_from_this_script?(uid)
    Call.find_by_calling_script_id_and_user_id(id, uid).present?
  end
  
  def record_call(rep_id, user_id)
    Call.find_or_create_by(
      :rep_id => rep_id,
      :calling_script_id => self.id,
      :user_id => user_id)
  end
  
end
