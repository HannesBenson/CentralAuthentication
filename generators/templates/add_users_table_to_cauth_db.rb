class AddUsersTableToCauthDb < CentralAuthentication::Migration
  def self.up
    ActiveRecord::Base.connection.initialize_schema_migrations_table
    if !table_exists?(:users)
      create_table :users do |t|
        t.column :email,                     :string, :limit => 100
        t.column :crypted_password,          :string
        t.column :password_salt,             :string
        t.column :created_at,                :datetime
        t.column :updated_at,                :datetime
        t.column :persistence_token,         :string
        t.column :perishable_token,          :string
        t.column :password_expires_on,       :date
      end
    end
  end

  def self.down
    drop_table :users
  end
end
