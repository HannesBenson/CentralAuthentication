class CreateCentralAuthenticationUsers < ActiveRecord::Migration
  def self.up
    User.all.each do |user|
      cu = CentralAuthentication::User.find_by_email user.email
      if cu.nil?
        cu = CentralAuthentication::User.create(:email => user.email, :password_salt => user.password_salt, :crypted_password => user.crypted_password, :perishable_token => user.perishable_token, :persistence_token => user.persistence_token)
        puts "Create user #{user.name}"
      else
        puts "Updating user #{user.name}"
      end
      user.update_attribute(:central_auth_user_id, cu.id)
    end
  end
 
  def self.down
  end
end
