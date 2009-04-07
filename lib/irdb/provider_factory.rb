module IRDb
  class ProviderFactory
    def self.get_provider(provider_name)
      provider = System::Data::Common::DbProviderFactories.get_factory(provider_name)
      
      if defined?(System::Data::DataTable)
        def provider.create_data_table
          System::Data::DataTable.new
        end
      end
      
      provider
    end
  end
end