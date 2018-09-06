# == Schema Information
#
# Table name: users
#
#  id    :bigint(8)        not null, primary key
#  email :string           not null
#

class User < ApplicationRecord
  validates :email, uniqueness: true
  
  has_many :submitted_urls,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :ShortenedURL
  
  has_many :visits,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Visit 
  
  has_many :visited_urls,
  through: :visits,
  source: :shortened_url
  
end
