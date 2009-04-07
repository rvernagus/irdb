module IRDb
  class DbProviderFactory
    def get_provider(provider_name)
      provider = System::Data::Common::DbProviderFactories.get_factory(provider_name)
      def provider.create_data_table
        System::Data::DataTable.new
      end
      
      provider
    end
  end
end