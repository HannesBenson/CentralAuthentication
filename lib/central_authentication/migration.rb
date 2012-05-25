class CentralAuthentication::Migration < ActiveRecord::Migration
  def self.connection 
    CentralAuthentication::Connection.connection 
  end 

  def connection 
    CentralAuthentication::Connection.connection 
  end 
end
