class ShortenedURL < ApplicationRecord 
  validates :short_url, uniqueness: true
  
  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User
  
  has_many :visits,
  primary_key: :id,
  foreign_key: :url_id,
  class_name: :Visit
  
  has_many :visitors,
  through: :visits,
  source: :user 
  
  def self.random_code
    short_code = SecureRandom.urlsafe_base64(n=16)
    while ShortenedURL.exists?(short_code)
      short_code = SecureRandom.urlsafe_base64(n=16)
    end 
    short_code
  end 
  
  def self.new_short_url(long_url, user_id)
    ShortenedURL.create!(short_url: ShortenedURL.random_code, long_url: long_url, user_id: user_id)
  end 
  
  def num_clicks 
    self.visits.length 
  end
  
  def num_uniques
    self.visitors.uniq.length 
  end 
  
  def num_recent_uniques(time)
    
  end  
  
end 