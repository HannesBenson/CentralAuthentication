# lib/generators/authr/authr_generator.rb
require 'rails/generators'
require 'rails/generators/migration'

class CentralAuthenticationGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end
  
  # Implement the required interface for Rails::Generators::Migration.
  # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S%6N")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_files
    migration_template 'add_auth_id_to_users.rb', 'db/migrate/add_auth_id_to_users.rb'
    migration_template 'add_users_table_to_cauth_db.rb', 'db/migrate/add_users_table_to_cauth_db.rb'
    migration_template 'create_central_authentication_users.rb', 'db/migrate/create_central_authentication_users.rb'
    migration_template 'remove_password_related_fields_from_user.rb', 'db/migrate/remove_password_related_fields_from_user.rb'
  end
end
