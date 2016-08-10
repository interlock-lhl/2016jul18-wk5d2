class User < ActiveRecord::Base
  include BCrypt

  validates :email, uniqueness: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def is_admin?
    id == 1
  end
end
