class AddAuthIdToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.references :central_auth_user
    end
  end

  def self.down
    remove_column :users, :central_auth_user_id
  end
end
