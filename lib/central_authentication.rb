require 'authlogic'
if defined?(Rails::Railtie)
  require 'central_authentication/railtie'
else
  require 'central_authentication/version'
  require 'central_authentication/connection'
  require 'central_authentication/migration'
  require 'central_authentication/user'
  require 'central_authentication/acts_as_central_authentication_user'
end
