module ActiveRecord
  module Acts
    module ActsAsCentralAuthenticationUser
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_central_authentication_user
          include InstanceMethods
          belongs_to :central_auth_user, :foreign_key => 'central_auth_user_id', :class_name => 'CentralAuth::User'

          attr_accessor :password_confirmation, :password

          acts_as_authentic do |config|
            config.login_field = :email
            config.validate_password_field = false
          end

          validates_presence_of :password
          validates_presence_of :password_confirmation
          validates_format_of :password, :with => /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{9,15}$/,
                              :message => 'must contain at least one uppercase and one lowercase letter as well as at least one numerical character.'
          validates_format_of :password, :with => /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{9,15}$/,
                              :message => 'must contain at least one uppercase and one lowercase letter as well as at least one numerical character.'
          validates_confirmation_of :password

          before_create :create_or_set_cauth_user
        end
      end
      module InstanceMethods
        def create_or_set_cauth_user
          user = CentralAuthentication::User.find_by_email(self.email)
          if user.nil?
            user = CentralAuthentication::User.create(:email => self.email, :password => self.password, :password_confirmation => self.password_confirmation, :password_expires_on => Date.today + 30.days, :persistence_token => self.persistence_token)
          end
          self.central_auth_user_id = user.id
        end

        def persistence_token
          central_auth_user.persistence_token
        end

        def persistence_token=(value)
          central_auth_user.update_attribute(persistence_token, value)
        end

        def persistence_token_changed?
          central_auth_user.persistence_token_changed?
        end

        protected
        def valid_central_auth_credentials(password)
          CentralAuthentication::User.valid?(self.email, password)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::ActsAsCentralAuthenticationUser)
