module NetDb
  class Database
    def initialize(provider_name, connection_string)
      @provider = ProviderFactory.get_provider(provider_name)
      @cstr = connection_string
    end
    
    def get_connection
      @provider.create_connection
    end
    
    def create_command
      @provider.create_command
    end

    def create_parameter(options={})
      p = @provider.create_parameter
      p.parameter_name = options[:name] || options[:parameter_name]
      p.value = options[:value]
      p
    end
    
    def make_command(options={})
      conn, cmd = get_connection, create_command
      conn.connection_string = @cstr
      conn.open
      cmd.connection = conn
      cmd.command_text = options[:sql]
      cmd
    end
    
    def use_command(options={})
      begin
        cmd = make_command(options)
        yield cmd if block_given?
      ensure
        cmd.connection.close
      end
    end
    
    def execute_non_query(options={})
      use_command(options) do |cmd|
        yield cmd if block_given?
        cmd.execute_non_query
      end
    end
    
    def execute_scalar(options={})
      use_command(options) do |cmd|
        yield cmd if block_given?
        cmd.execute_scalar
      end
    end
    
    def execute_reader(options={})
      use_command(options) do |cmd|
        begin
          reader = cmd.execute_reader
          while reader.read
            yield reader
          end
        ensure
          reader.dispose
        end
      end
    end
    
    def execute_table(options={})
      use_command(options) do |cmd|
        begin
          adapter = @provider.create_data_adapter
          table = @provider.create_data_table
          yield cmd if block_given?
          adapter.select_command = cmd
          adapter.fill(table)
          table
        ensure
          adapter.dispose
        end
      end
    end
  end
end
