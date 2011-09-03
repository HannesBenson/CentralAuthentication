class AddUsersTableToCauthDb < CentralAuth::Migration
  def self.up
    ActiveRecord::Base.connection.initialize_schema_migrations_table
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

  def self.down
    drop_table :users
  end
end
