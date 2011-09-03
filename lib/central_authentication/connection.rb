class CentralAuthentication::Connection < ActiveRecord::Base 
  self.abstract_class = true
  self.establish_connection :cauth

  def self.table_name_prefix
    "cauth_#{Rails.env}."
  end
end
