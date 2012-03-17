class RemovePasswordRelatedFieldsFromUser < ActiveRecord::Migration
  def self.up
    if column_exists? :users, :password_salt
      remove_column :users, :password_salt
    end
    if column_exists? :users, :crypted_password
      remove_column :users, :crypted_password
    end
    if column_exists? :users, :persistence_token
      remove_column :users, :persistence_token
    end
    if column_exists? :users, :perishable_token
      remove_column :users, :perishable_token
    end
  end

  def self.down
    unless column_exists? :users, :password_salt
      add_column :users, :password_salt, :string
    end
    unless column_exists? :users, :crypted_password
      add_column :users, :crypted_password, :string
    end
    unless column_exists? :users, :persistence_token
      add_column :users, :persistence_token, :string
    end
    unless column_exists? :users, :perishable_token
      add_column :users, :perishable_token, :string
    end
  end
end
