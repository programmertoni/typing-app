class User < ApplicationRecord
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(plain_text)
    @password = Password.create(plain_text)
    self.password_hash = @password
  end
end
