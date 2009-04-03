require "test/unit"
require "lib/netdb"
require "helpers/fake_provider"
require "helpers/fake_reader"
require "helpers/fake_data_adapter"

class DatabaseTest < Test::Unit::TestCase
  def setup
    @provider = FakeProvider.new
    System::Data::Common::DbProviderFactories.get_factory_returns(@provider)
    @db = NetDb::Database.new("System.Data.SqlClient", "connection string")    
  end
  
  def test_get_connection
    assert_equal @provider.connection, @db.get_connection
  end
  
  def test_create_command
    assert_equal @provider.command, @db.create_command
  end
  
  def test_create_parameter
    assert_equal @provider.parameter, @db.create_parameter
  end
  
  def test_use_command_opens_connection
    assert !@provider.connection.opened?
    @db.use_command
    assert @provider.connection.opened?
  end
  
  def test_use_command_sets_connection_string
    assert_nil @provider.connection.connection_string
    @db.use_command
    assert_equal "connection string", @provider.connection.connection_string
  end
  
  def test_use_command_sets_command_connection
    assert_nil @provider.command.connection
    @db.use_command
    assert_equal @provider.connection, @provider.command.connection
  end
  
  def test_use_command_closes_connection
    assert !@provider.connection.closed?
    @db.use_command
    assert @provider.connection.closed?
  end
  
  def test_use_command_yields_command
    result = nil
    @db.use_command { |cmd| result = cmd }
    assert_equal @provider.command, result
  end
  
  def test_use_command_ensures_connection_is_closed
    assert !@provider.connection.closed?
    begin
      @db.use_command { |cmd| raise Exception }
    rescue Exception; end
    assert @provider.connection.closed?
  end
  
  def test_execute_non_query_executes_command
    @provider.command.query_result[:non_query] = 99
    assert_equal 99, @db.execute_non_query
  end
  
  def test_execute_non_query_sets_command_text
    assert_nil @provider.command.command_text
    @db.execute_non_query(:sql => "expected")
    assert_equal "expected", @provider.command.command_text
  end
  
  def test_execute_non_query_yields_command
    result = nil
    @db.execute_non_query { |cmd| result = cmd }
    assert_equal @provider.command, result
  end
  
  def test_create_parameter_with_name
    param = @db.create_parameter(:name => "expected")
    assert_equal "expected", param.parameter_name
  end
  
  def test_create_parameter_with_parameter_name
    param = @db.create_parameter(:parameter_name => "expected")
    assert_equal "expected", param.parameter_name
  end
  
  def test_create_parameter_with_value
    param = @db.create_parameter(:value => "expected")
    assert_equal "expected", param.value
  end
  
  def test_execute_scalar_executes_command
    @provider.command.query_result[:scalar] = 99
    assert_equal 99, @db.execute_scalar
  end
  
  def test_execute_scalar_sets_command_text
    assert_nil @provider.command.command_text
    @db.execute_scalar(:sql => "expected")
    assert_equal "expected", @provider.command.command_text
  end
  
  def test_execute_scalar_yields_command
    result = nil
    @db.execute_scalar { |cmd| result = cmd }
    assert_equal @provider.command, result
  end
  
  def test_execute_reader_yields_reader
    reader = FakeReader.new(1)
    @provider.command.query_result[:reader] = reader
    result = nil
    @db.execute_reader { |rdr| result = rdr }
    assert_equal reader, result
  end
  
  def test_execute_reader_yields_reader_while_read_is_true
    @provider.command.query_result[:reader] = FakeReader.new(2)
    num_yields = 0
    @db.execute_reader { |rdr| num_yields += 1 }
    assert_equal 2, num_yields
  end
  
  def test_execute_reader_ensures_reader_is_disposed
    reader = FakeReader.new(1)
    @provider.command.query_result[:reader] = reader
    begin
      @db.execute_reader { |rdr| raise Exception }
    rescue Exception; end
    assert reader.disposed?
  end
  
  def test_execute_table_fills_and_returns_table
    table = @db.execute_table
    assert @provider.data_adapter.filled?
    assert_equal @provider.data_table, table
  end
  
  def test_execute_table_sets_select_command
    @db.execute_table
    assert_equal @provider.command, @provider.data_adapter.select_command
  end
  
  def test_execute_table_ensures_adapter_is_disposed
    begin
      @db.execute_table { |cmd| raise Exception }
    rescue Exception; end
    assert @provider.data_adapter.disposed?
  end
  
  def test_execute_table_yields_command
    result = nil
    @db.execute_table { |cmd| result = cmd }
    assert_equal @provider.command, result
  end
end