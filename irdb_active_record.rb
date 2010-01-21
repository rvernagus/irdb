require 'System.Data'
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
      
      ConnectionAdapters::IrdbAdapter.new(connection, logger)
    end
  end
  
  module ConnectionAdapters
    class IrdbColumn < Column #:nodoc:
    end
    
    class IrdbAdapter < AbstractAdapter
      #def initialize(connection, logger, config)
      #  super(connection, logger)
      #end
      
      #def quote(value, column = nil)
      #  p "===> quote #{value.inspect} #{column.inspect}"
      #  return quote_string(value) if value.kind_of?(String)
      #  value
      #end
      
      def native_database_types #:nodoc:
        puts "===> native_database_types"
        {
          :primary_key => "int NOT NULL IDENTITY(1, 1) PRIMARY KEY",
          :string => { :name => 'varchar', :limit => 255 },
          :text => { :name => 'varchar', :limit => :max },
          :integer => { :name => "int", :limit => 4 },
          :float => { :name => "float", :limit => 8 },
          :decimal => { :name => "decimal" },
          :datetime => { :name => "datetime" },
          :timestamp => { :name => "datetime" },
          :time => { :name => "datetime" },
          :date => { :name => "datetime" },
          :binary => { :name => 'varbinary', :limit => :max },
          :boolean => { :name => "bit"},
          :char => { :name => 'char' },
          :varchar_max => { :name => 'varchar', :limit => :max },
          :nchar => { :name => "nchar" },
          :nvarchar => { :name => "nvarchar", :limit => 255 },
          :nvarchar_max => { :name => "nvarchar", :limit => :max },
          :ntext => { :name => "ntext" }
        }
      end
      
      def quote_column_name(name) #:nodoc:
        puts "===> quote_column_name #{name.inspect}"
        name =~ /\[.+\]/ ? name : "[#{name}]" 
      end

      #def quote_string(string) #:nodoc:
      #  "'#{string}'"
      #end

      def execute(sql, name = nil) #:nodoc:
        puts "===> execute #{sql.inspect}"
        log(sql, name) do
          cmd = @connection.command(sql)
          if block_given?
            @connection.while_open { yield cmd }
          else
            @connection.while_open { cmd.execute_non_query }
          end
        end
      end
      
      def select(sql, name = nil)
        puts "===> select #{sql.inspect}"
        execute(sql, name) { |cmd| cmd.execute_reader.to_a }
      end
      
      def execute_scalar(sql, name = nil) #:nodoc:
        puts "===> execute_scalar #{sql.inspect}"
        execute(sql, name) { |cmd| cmd.execute_scalar }
      end
      
      def insert(sql, name = nil, pk = nil, id_value = nil, sequence_name = nil)
        puts "===> insert #{sql.inspect}"
        sql << "; SELECT SCOPE_IDENTITY();"
        execute_scalar(sql, name)
      end
      
      def columns(table_name, name = nil)#:nodoc:
        puts "===> columns #{table_name.inspect}"
        execute("SELECT TOP 1 * FROM #{table_name}", name) do |cmd|
          reader = cmd.execute_reader
          schema_table = reader.get_schema_table
          schema_table.rows.collect do |schema_row|
            IrdbColumn.new(schema_row['ColumnName'].to_s, nil, schema_row['DataTypeName'], schema_row['AllowDbNull'])
          end
        end
      end
      
      def type_to_sql(type, limit = nil, precision = nil, scale = nil)
        puts "===> type_to_sql #{type.inspect}"
        super
      end
      
      def pk_and_sequence_for(table_name)
        puts "==> pk_and_sequence_for #{table_name.inspect}"
        super
      end
      
      def add_limit_offset!(sql, options) #:nodoc:
        puts "===> add_limit_offset! #{sql.inspect} #{options.inspect}"
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
