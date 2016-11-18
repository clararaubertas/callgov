class CallingScript < ActiveRecord::Base
  validates_presence_of :content, :topic, :user
  belongs_to :user
end
