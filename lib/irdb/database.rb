module IRDb
  class Database
    attr_reader :provider
    
    def initialize(provider, connection_string)
      @provider = provider
      @conn = @provider.create_connection
      @conn.connection_string = connection_string
      @state = DatabaseState.new
    end
    
    def begin_connection
      return @state.connection if @state.connected?
      @conn.open
      @state.connection = @conn
    end
    
    def end_connection
      return self unless @state.connected?
      conn = @state.connection
      conn.close
      @state.connection = nil
      self
    end
    
    def begin_transaction
      return @state.transaction if @state.in_transaction?
      conn = begin_connection
      t = conn.begin_transaction
      @state.transaction = t
    end
    
    def end_transaction
      @state.transaction = nil
      self
    end
    
    def connection
      begin
        conn = begin_connection
        yield conn if block_given?
      ensure
        end_connection
      end
    end
    
    def transaction
      t = begin_transaction
      begin
        yield t if block_given?
        t.commit
      rescue Exception
        t.rollback
        raise
      ensure
        end_transaction
      end
    end
    
    def command(commmand_text)
      cmd = provider.create_command
      cmd.connection = @conn
      cmd.transaction = @state.transaction if @state.in_transaction?
      cmd.command_text = commmand_text
      cmd
    end
    
    def add_parameter(cmd, options={})
      param = @provider.create_parameter
      param.parameter_name = options[:name] || options[:parameter_name]
      param.value = options[:value]
      param.db_type = options[:type] if options[:type]
      param.db_type = options[:db_type] if options[:db_type]
      param.direction = options[:direction] if options[:direction]
      param.size = options[:size] if options[:size]
      param.source_column = options[:source_column]
      cmd.parameters.add(param)
    end
    
    def execute_non_query(command_text)
      begin_connection
      cmd = command(command_text)
      yield cmd if block_given?
      cmd.execute_non_query
    end
    
    def execute_scalar(command_text)
      begin_connection
      cmd = command(command_text)
      yield cmd if block_given?
      cmd.execute_scalar
    end
    
    def execute_table(command_text)
      begin_connection
      cmd = command(command_text)
      table = @provider.create_data_table
      adapter = @provider.create_data_adapter
      yield cmd if block_given?
      adapter.select_command = cmd
      adapter.fill table
      table
    end
    
    def execute_reader(cmd)
      begin
        rdr = cmd.execute_reader
        while rdr.read
          yield rdr
        end
      ensure
        rdr.dispose if rdr
      end
    end
    
    def execute_hash(command_text)
      begin_connection
      cmd = command(command_text)
      yield cmd if block_given?
      results = []
      execute_reader(cmd) do |rdr|
        result = {}
        0.upto(rdr.field_count - 1) do |i|
          result[rdr.get_name(i).to_s.downcase] = rdr.get_value(i)
        end
        results << result
      end
      results
    end
  end
  
  class DatabaseState
    attr_accessor :connection, :transaction
    
    def initialize
      @connection = @transaction = nil
    end
    
    def connected?
      !@connection.nil?
    end
    
    def in_transaction?
      !@transaction.nil?
    end
  end
end
