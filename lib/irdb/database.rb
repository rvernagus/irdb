module IRDb
  class Database
    attr_reader :provider
    
    def initialize(provider, connection_string)
      @provider = provider
      @conn = @provider.create_connection
      @conn.connection_string = connection_string
    end
    
    def connection
      begin
        @conn.open
        yield @conn if block_given?
      ensure
        @conn.close
      end
    end
    
    def transaction
      connection do |conn|
        t = @conn.begin_transaction
        begin
          yield t if block_given?
          t.commit
        rescue Exception
          t.rollback
          raise
        end
      end
    end
  end
end
