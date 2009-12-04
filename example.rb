require "System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"

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
    
    def execute(&block)
      block.call(create_command)
    end
    
    def execute_non_query(cmd_text)
      execute do |cmd|
        cmd.command_text = cmd_text
        cmd.execute_non_query
      end
    end
    
    def execute_reader(cmd_text)
      execute do |cmd|
        cmd.command_text = cmd_text
        cmd.execute_reader
      end
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
conn.while_open do
  puts "state => #{conn.state}"
  
  p (conn.execute_non_query "SELECT COUNT(*) FROM Production.Product")
  
  reader = conn.execute_reader "SELECT TOP 10 * FROM Production.Product"
  reader.while_read do
    p "#{reader.productid}, #{reader.name}, #{reader.productnumber}"
  end
  puts "#{reader.records_affected} rows selected"
  
end

puts "state => #{conn.state}"



