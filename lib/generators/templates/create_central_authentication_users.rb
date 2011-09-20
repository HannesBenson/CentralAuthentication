class CreateCentralAuthenticationUsers < ActiveRecord::Migration
  def self.up
    User.all.each do |user|
      cu = CentralAuthentication::User.find_by_email user.email
      if cu.nil?
        cu = CentralAuthentication::User.create(:email => user.email, :password_salt => user.password_salt, :crypted_password => user.crypted_password, :perishable_token => user.perishable_token, :persistence_token => user.persistence_token)
      end
      user.update_attribute(:central_auth_user_id, cu.id)
      puts user.inspect
    end
  end
 
  def self.down
  end
end
