require 'central_authentication'
require 'rails'

module CentralAuthentication
  class Railtie < Rails::Railtie
    initializer "central_authentication.configure_rails_initialization" do
      require 'central_authentication/version'
      require 'central_authentication/connection'
      require 'central_authentication/migration'
      require 'central_authentication/user'
      require 'central_authentication/acts_as_central_authentication_user'
    end
    rake_tasks do
      load 'central_authentication/tasks.rb'
    end
  end
end
