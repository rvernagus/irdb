require 'System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
require 'lib/irdb'

module System::Data::Common
  class DbConnection
    def while_open(&block)
      begin
        open
        block.call
      ensure
        close
      end
    end
    
    def command(cmd_text)
      cmd = create_command
      cmd.command_text = cmd_text
      cmd
    end
    
    def execute_non_query(cmd_text)
      cmd = command(cmd_text)
      cmd.execute_non_query
    end
    
    def execute_reader(cmd_text)
      cmd = command(cmd_text)
      cmd.execute_reader
    end
    
    def execute_scalar(cmd_text)
      cmd = command(cmd_text)
      cmd.execute_scalar
    end
    
    def execute_table(cmd_text)
      reader = execute_reader(cmd_text)
      table = System::Data::DataTable.new
      table.load reader
      table
    end
  end
  
  class DbDataReader
    def while_read(&block)
      block.call while read
      close
    end
    
    def method_missing(symbol, *args, &block)
      col_name = symbol.to_s
      get_ordinal(col_name) rescue super
      self[col_name]
    end
    
    def current_to_hash
      h = {}
      0.upto(field_count - 1) do |i|
        col_name = get_name(i).to_s
        h[col_name] = self[i]
      end
      h
    end
    alias :current_to_h :current_to_hash
    
    def to_array
      rows = []
      while_read { rows << current_to_hash }
      rows
    end
    alias :to_a :to_array
  end
end

module ActiveRecord
  class Base
    # Establishes a connection to the database that's used by all Active Record objects.
    def self.irdb_connection(config) # :nodoc:
      factory = System::Data::Common::DbProviderFactories.get_factory(config[:provider])
      connection = factory.create_connection
      connection.connection_string = config[:connection_string]
      
      ConnectionAdapters::IrdbAdapter.new(connection, logger, config)
    end
  end
  
  module ConnectionAdapters
    class IrdbColumn < Column #:nodoc:
    end
    
    class IrdbAdapter < AbstractAdapter
      def initialize(connection, logger, config)
        super(connection, logger)
      end
      
      #def quote(value, column = nil)
      #  p "===> quote #{value.inspect} #{column.inspect}"
      #  return quote_string(value) if value.kind_of?(String)
      #  value
      #end
      
      def quote_column_name(name) #:nodoc:
        puts "===> quote_column_name #{name.inspect}"
        "[#{name}]"
      end

      #def quote_string(string) #:nodoc:
      #  "'#{string}'"
      #end
      
      def select(sql, name = nil)
        puts "===> select #{sql.inspect}"
        @connection.while_open do
          reader = @connection.execute_reader(sql)
          reader.to_a
        end
      end
      
      def execute(sql, name = nil) #:nodoc:
        puts "===> execute #{sql.inspect}"
        log(sql, name) do
          @connection.while_open do
            @connection.execute_non_query sql
          end
        end
      end
      
      def execute_scalar(sql, name = nil) #:nodoc:
        puts "===> execute_scalar #{sql.inspect}"
        log(sql, name) do
          @connection.while_open do
            @connection.execute_scalar sql
          end
        end
      end
      
      def insert(sql, name = nil, pk = nil, id_value = nil, sequence_name = nil)
        puts "===> insert #{sql.inspect}"
        sql << "; SELECT SCOPE_IDENTITY();"
        execute_scalar(sql, name)
      end
      
      def columns(table_name, name = nil)#:nodoc:
        puts "===> columns #{table_name.inspect}"
        @connection.while_open do
          reader = @connection.execute_reader("SELECT TOP 1 * FROM #{table_name}")
          schema_table = reader.get_schema_table
          schema_table.rows.collect do |schema_row|
            IrdbColumn.new(schema_row['ColumnName'].to_s, nil, schema_row['DataTypeName'], schema_row['AllowDbNull'])
          end
        end
      end
      
      def type_to_sql(type, limit = nil, precision = nil, scale = nil)
        puts "===> type_to_sql #{type.inspect}"
      end
      
      def pk_and_sequence_for(table_name)
        puts "==> pk_and_sequence_for #{table_name.inspect}"
      end
      
      def add_limit_offset!(sql, options) #:nodoc:
        puts "===> add_limit_offset! #{sql.inspect}"
        if limit = options[:limit]
          limit = sanitize_limit(limit)
          unless offset = options[:offset]
            sql.gsub!(/SELECT/i, "SELECT TOP #{limit}")
          else
            sql << " LIMIT #{offset.to_i}, #{limit}"
          end
        end
      end
    end
  end
end
