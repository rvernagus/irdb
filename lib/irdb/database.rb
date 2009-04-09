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
    
    def add_parameter(cmd, options={})
      param = @provider.create_parameter
      param.parameter_name = options[:name] || options[:parameter_name]
      param.value = options[:value]
      param.db_type = options[:type] if options[:type]
      param.db_type = options[:db_type] if options[:db_type]
      param.direction = options[:direction] if options[:direction]
      cmd.parameters.add(param)
    end
    
    def execute_scalar(command_text)
      connection do |c|
        command(command_text) do |cmd|
          yield cmd if block_given?
          cmd.execute_scalar
        end
      end
    end
  end
end
