require "System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"

module System::Data
  class DataRow
    def to_hash
      table.columns.inject({}) { |h, col| h[col.to_s] = self[col]; h }
    end
    alias :to_h :to_hash
    
    def method_missing(symbol, *args, &block)
      col_name = symbol.to_s
      super unless table.columns.contains(col_name)
      self[col_name]
    end
  end
  
  class DataTable
    def to_array
      rows.collect { |row| row.to_hash }
    end
    alias :to_a :to_array
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
    
    def current_to_hash
      h = {}
      0.upto(visible_field_count - 1) do |i|
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

# current_to_hash
conn.while_open do
  reader = conn.execute_reader "SELECT TOP 10 * FROM Production.Product"
  reader.while_read do
    p reader.current_to_hash
  end
end

# to_a
conn.while_open do
  reader = conn.execute_reader "SELECT TOP 10 * FROM Production.Product"
  p reader.to_a
end

# Adds methods to DataTable and DataRow
# to_array | to_a
conn.while_open do
  table = conn.execute_table "SELECT TOP 10 * FROM Production.Product"
  p table.to_a
end

# Adds methods to DataRow
# method_missing
conn.while_open do
  table = conn.execute_table "SELECT TOP 10 * FROM Production.Product"
  table.rows.each do |row|
    p "#{row.productid}, #{row.name}, #{row.productnumber}"
  end
end
