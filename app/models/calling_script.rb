class CallingScript < ActiveRecord::Base
  validates_presence_of :content, :topic, :user, :summary
  belongs_to :user
end
