class User < ActiveRecord::Base
  has_many :secrets #all the secrets the user has created
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret #all the secrets the user has liked
  has_secure_password

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :presence => true
  validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
  validates :password, on:create, :presence => true
end
