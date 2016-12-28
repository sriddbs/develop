class UserUrlVisit < ActiveRecord::Base
  belongs_to :user
  belongs_to :link
end
