class CentralAuthentication::User < CentralAuthentication::Connection
  acts_as_authentic do |config|
    #config.merge_validates_length_of_password_field_options({:minimum => 9})
    #config.merge_validates_length_of_password_confirmation_field_options({:minimum => 9})
    config.login_field = :email
    config.validate_password_field = false
  end

  def self.valid?(email, password)
    return false if !(cu = CentralAuthentication::User.find_by_email(email))
    cu.valid_password?(password)
  end
end
