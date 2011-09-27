class CentralAuthenticationGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'add_auth_id_to_users.rb', 'db/migrate', :migration_file_name => 'add_auth_id_to_users.rb'
      m.sleep(2)
      m.migration_template 'add_users_table_to_cauth_db.rb', 'db/migrate', :migration_file_name => 'add_users_table_to_cauth_db.rb'
      m.sleep(2)
      m.migration_template 'create_central_authentication_users.rb', 'db/migrate', :migration_file_name => 'create_central_authentication_users.rb'
      m.sleep(2)
      m.migration_template 'remove_password_related_fields_from_user.rb', 'db/migrate', :migration_file_name => 'remove_password_related_fields_from_user.rb'
    end
  end
end
