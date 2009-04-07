module IRDb
  class Database
    attr_reader :provider
    
    def initialize(provider, connection_string)
      @provider = provider
      @connection = @provider.create_connection
      @connection.connection_string = connection_string
    end
  end
end
