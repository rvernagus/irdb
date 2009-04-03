# This class fakes out the DbProviderFactories .NET class for testing
# It's also one of the few depencines that DbNet has on a .NET class
module System
  module Data
    module Common
      class DbProviderFactories
        class << self
          def get_factory_returns(obj)
            @@last_call_return = obj
          end
          
          def get_factory_last_called_with
            @@last_call
          end
          
          def get_factory(name)
            @@last_call = name
            @@last_call_return
          end
        end
      end
    end
  end
end
