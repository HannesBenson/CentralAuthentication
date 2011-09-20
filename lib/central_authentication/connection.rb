class CentralAuthentication::Connection < ActiveRecord::Base 
  establish_connection "cauth_#{Rails.env}"
  self.abstract_class = true
end
