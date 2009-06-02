require "fake_db_command"
require "fake_db_connection"
require "fake_db_parameter"

class FakeProvider
  attr_accessor :connection, :command, :parameter,
                :data_adapter, :data_table
  
  def initialize
    @connection   = FakeDbConnection.new
    @command      = FakeDbCommand.new
    @parameter    = FakeDbParameter.new
    @data_adapter = mock("DbDataAdapter")
    @data_table   = System::Data::DataTable.new
  end
  
  def create_connection
    connection
  end
  
  def create_command
    command
  end
  
  def create_parameter
    parameter
  end
  
  def create_data_adapter
    data_adapter
  end
  
  def create_data_table
    data_table
  end
end
