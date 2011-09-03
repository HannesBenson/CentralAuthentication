class CentralAuthentication::Migration < ActiveRecord::Migration
  def self.connection 
    CentralAuthentication::Connection.connection 
  end 
end
