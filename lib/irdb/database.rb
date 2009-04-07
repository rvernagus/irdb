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
      t = @conn.begin_transaction
      @current_transaction = t
      begin
        yield t if block_given?
        t.commit
      rescue Exception
        t.rollback
        raise
      ensure
        @current_transaction = nil
      end
    end
    
    def command(commmand_text)
      cmd = provider.create_command
      cmd.connection = @conn
      cmd.transaction = @current_transaction
      cmd.command_text = commmand_text
      yield cmd
    end
  end
end
