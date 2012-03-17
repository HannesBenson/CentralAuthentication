class CentralAuthentication::User < CentralAuthentication::Connection
  acts_as_authentic do |config|
    config.login_field = :email
    config.validate_password_field = false
    config.session_class = UserSession
  end

  def self.valid?(email, password)
    return false if !(cu = CentralAuthentication::User.find_by_email(email))
    cu.valid_password?(password)
  end
end
