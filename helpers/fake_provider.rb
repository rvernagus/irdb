require "helpers/fake_connection"
require "helpers/fake_command"
require "helpers/fake_parameter"
require "helpers/fake_data_adapter"
require "helpers/fake_data_table"

class FakeProvider
  attr_accessor :connection, :command, :parameter,
                :data_adapter, :data_table
  
  def initialize
    self.connection = FakeConnection.new
    self.command = FakeCommand.new
    self.parameter = FakeParameter.new
    self.data_adapter = FakeDataAdapter.new
    self.data_table = FakeDataTable.new
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
