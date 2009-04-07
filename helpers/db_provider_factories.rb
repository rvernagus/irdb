# This class fakes out the DbProviderFactories .NET class for testing
# It's also one of the few depencines that DbNet has on a .NET class
module System
  module Data
    module Common
      class DbProviderFactories
        class << self
          attr_accessor :provider_name, :factory
          
          def get_factory(name)
            self.provider_name = name
            factory
          end
        end
      end
    end
  end
end
