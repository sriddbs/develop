class Link < ActiveRecord::Base
  BASE_URL = "http://pte.ly"

  def self.generate_key
    (("0".."9").to_a + ("A".."Z").to_a + ("a".."z").to_a).shuffle.first(6).join
  end

  def short_url
    [BASE_URL, self.key].join("/")
  end
end
