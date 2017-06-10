class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  include ActiveModel::Validations
  include Rails.application.routes.url_helpers
  field :email, type: String
  field :username, type: String
  field :password_digest, type: String
  field :points , type: Integer
  field :fakes , type: Integer
  field :flage , type: Integer
  mount_base64_uploader :avatar, AvatarUploader, file_name: -> (u) { u.id }
  has_many :prices
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: [ :create, :update ] }
  validates :username, presence: true
  has_secure_password 
end