class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  validates :password, length:{minimum: 8}
  has_secure_password
end
