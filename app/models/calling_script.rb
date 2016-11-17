class CallingScript < ActiveRecord::Base
  validates_presence_of :content, :topic
end
