class User < ApplicationRecord
    has_many :measures, dependent: :destroy

    validates_presence_of(:name, :email, :password_digest)
end
