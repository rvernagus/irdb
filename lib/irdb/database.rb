module IRDb
  class Database
    attr_reader :provider
    
    def initialize(provider, connection_string)
      @provider = provider
      @conn = @provider.create_connection
      @conn.connection_string = connection_string
      @statebag = {}
    end
    
    def begin_connection
      @conn.open
      @statebag[:connection] = @conn
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
      param.size = options[:size] if options[:size]
      param.source_column = options[:source_column]
      cmd.parameters.add(param)
    end
    
    def execute_non_query(command_text)
      connection do |c|
        command(command_text) do |cmd|
          yield cmd if block_given?
          cmd.execute_non_query
        end
      end
    end
    
    def execute_scalar(command_text)
      connection do |c|
        command(command_text) do |cmd|
          yield cmd if block_given?
          cmd.execute_scalar
        end
      end
    end
    
    def execute_table(command_text)
      connection do |c|
        command(command_text) do |cmd|
          table = @provider.create_data_table
          adapter = @provider.create_data_adapter
          yield cmd if block_given?
          adapter.select_command = cmd
          adapter.fill table
          table
        end
      end
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
      connection do |c|
        command(command_text) do |cmd|
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
    end
  end
end
