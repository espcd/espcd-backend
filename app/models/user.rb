class User < ApplicationRecord
  has_many :tokens, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_secure_password
end
