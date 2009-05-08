require 'active_record/connection_adapters/abstract_adapter'

module ActiveRecord
  class Base
    def self.irdb_connection(config)
      provider_name = config[:provider] || config[:provider_name]
      cstr          = config[:cstr] || config[:connection_string]
      
      provider_factory = IRDb::DbProviderFactory.new
      #provider = provider_factory.create_provider(provider_name)
      provider = FakeProvider.new
      db = IRDb::Database.new(provider, cstr)
      ConnectionAdapters::IrdbAdapter.new(db, logger, config)
    end
  end
  
  module ConnectionAdapters
    class IrdbColumn < Column
      
    end
    
    class IrdbAdapter < AbstractAdapter
      def initialize(connection, logger, config)
        super(connection, logger)
        @config = config
      end
      
      def columns(table_name, name=nil)
        [IrdbColumn.new("id", nil, :integer),
         IrdbColumn.new("wow_class", nil, :string),
         IrdbColumn.new("level", nil, :integer),
         IrdbColumn.new("slogan", nil, :string)]
      end
    end
  end
end
