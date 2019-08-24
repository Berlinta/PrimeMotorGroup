class User < ApplicationRecord
  has_secure_password

  has_many :reviews
  has_many :cars, through: :reviews
  validates :email, presence: true, uniqueness: {case_sensitive: :false}

end