module ActiveRecord
  module Acts
    module ActsAsCentralAuthenticationUser
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_central_authentication_user
          include InstanceMethods
          belongs_to :central_authentication_user, :foreign_key => 'central_auth_user_id', :class_name => 'CentralAuthentication::User'

          attr_accessor :password_confirmation, :password

          #Here we set the authlogic options:
          # 1. Email will be used as the login field
          # 2. It doesn't validate the password field against a database field
          # 3. It doesn't validate the login field. Authlogic automatically validates the email field.
          acts_as_authentic do |config|
            config.login_field = :email
            config.validate_password_field = false
            config.validate_login_field = false
          end

          validates_presence_of :password
          validates_presence_of :password_confirmation
          validates_format_of :password, :with => /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{9,15}$/,
                              :message => 'must contain at least one uppercase and one lowercase letter as well as at least one numerical character.'
          validates_format_of :password_confirmation, :with => /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{9,15}$/,
                              :message => 'must contain at least one uppercase and one lowercase letter as well as at least one numerical character.'
          validates_confirmation_of :password

          before_save :create_or_set_cauth_user
        end
      end
      module InstanceMethods
        def create_cauth_user
          CentralAuthentication::User.create(:email => self.email, :password => self.password, :password_confirmation => self.password_confirmation, :password_expires_on => Date.today + 30.days, :persistence_token => self.persistence_token)
        end

        def update_cauth_user(cauth_user)
          if self.password.blank?
            cauth_user.update_attributes(:email => self.email)
          else
            cauth_user.update_attributes(:password => self.password, :password_confirmation => self.password_confirmation, :email => self.email)
          end
        end

        def create_or_set_cauth_user
          cauth_user = CentralAuthentication::User.find_by_email(self.email)
          if cauth_user.nil?
            cauth_user = create_cauth_user
            self.central_auth_user_id = cauth_user.id
          else
            update_cauth_user(cauth_user)
          end
        end

        def persistence_token
          # This method returns the persistence_token from the central authentication user. If this user does not exist yet it returns a arbitrary string otherwise it fails validation.
          return 'a' if central_authentication_user.nil?
          central_authentication_user.persistence_token
        end

        def persistence_token=(value)
          return value if central_authentication_user.nil?
          central_authentication_user.update_attribute(persistence_token, value)
        end

        def persistence_token_changed?
          return false if central_authentication_user.nil?
          central_authentication_user.persistence_token_changed?
        end

        protected
        def valid_central_authentication_credentials(password)
          CentralAuthentication::User.valid?(self.email, password)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::ActsAsCentralAuthenticationUser)
