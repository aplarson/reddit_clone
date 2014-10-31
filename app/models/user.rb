# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :email, :password_digest, :session_token, presence: true
  validates :username, :email, :session_token, uniqueness: true
  after_initialize :ensure_session_token
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  private
    def ensure_session_token
      self.session_token ||= SecureRandom.urlsafe_base64
    end
  
end
