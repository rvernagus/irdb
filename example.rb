require "System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"

module System::Data
  class DataTable
    def to_hash
      rows.collect do |row|
        columns.inject({}) { |h, col| h[col.column_name.to_s] = row[col]; h }
      end
    end
    alias :to_h :to_hash
  end
end

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
  end
end

cstr = "Data Source=(local);Initial Catalog=AdventureWorks;Integrated Security=True"
conn = System::Data::SqlClient::SqlConnection.new(cstr)


# FEATURES

# Adds methods to DbConnection
# while_open
conn.while_open do
  puts "state => #{conn.state}"
end
puts "state => #{conn.state}"

# execute_non_query
conn.while_open do
  result = conn.execute_non_query "SELECT COUNT(*) FROM Production.Product"
  p result
end

# execute_reader
conn.while_open do
  reader = conn.execute_reader "SELECT TOP 10 * FROM Production.Product"
end

# execute_table
conn.while_open do
  table = conn.execute_table "SELECT TOP 10 * FROM Production.Product"
  puts "Table has #{table.rows.count} rows"
end

# Adds methods to DbDataReader
# while_read
conn.while_open do
  reader = conn.execute_reader "SELECT TOP 10 * FROM Production.Product"
  reader.while_read do
    # method_missing
    p "#{reader.productid}, #{reader.name}, #{reader.productnumber}"
  end
end

# Adds methods to DataTable
# to_hash | to_h
conn.while_open do
  table = conn.execute_table "SELECT TOP 10 * FROM Production.Product"
  p table.to_h
end
