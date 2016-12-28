class Link < ActiveRecord::Base
  has_many :user_url_visits
  has_many :users, through: :user_url_visits

  BASE_URL = "http://pte.ly"

  def self.generate_key
    (("0".."9").to_a + ("A".."Z").to_a + ("a".."z").to_a).shuffle.first(6).join
  end

  def generate_short_url
    [BASE_URL, self.key].join("/")
  end
end
