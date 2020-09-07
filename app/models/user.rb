class User < ApplicationRecord
  has_secure_password
  before_save { self.email = email.downcase}

    validates_length_of :password, minimum: 6

  has_many :measures, dependent: :destroy

  validates_presence_of(:name, :email, :password_digest)

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  validates_length_of :email, maximum: 255
  validates :email, uniqueness: {  scope: :id }, format: { with: VALID_EMAIL_REGEX}

 

end