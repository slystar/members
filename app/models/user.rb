class User < ApplicationRecord
  before_save :first_user_admin
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  validates :password, length:{minimum: 8}
  has_secure_password

  private
  def first_user_admin
    if User.all.size == 0
      self.admin = true
    end
  end
end
