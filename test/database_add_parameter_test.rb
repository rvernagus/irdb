require "database_test_fixture"

class DatabaseExecuteScalarTest < Test::Unit::TestCase
  include DatabaseTestFixture
  
  def setup
    super
    @cmd = @provider.command
  end
  
  def test_adds_parameter_to_command
    @db.add_parameter(@cmd)
    
    assert_equal 1, @cmd.parameters.length
  end
  
  def test_can_set_parameter_name_by_name
    @db.add_parameter(@cmd, :name => "name")
    
    assert_equal "name", @cmd.parameters.first.parameter_name
  end
  
  def test_can_set_parameter_name_by_parameter_name
    @db.add_parameter(@cmd, :parameter_name => "name")
    
    assert_equal "name", @cmd.parameters.first.parameter_name
  end
  
  def test_can_set_value
    @db.add_parameter(@cmd, :value => "value")
    
    assert_equal "value", @cmd.parameters.first.value
  end
  
  def test_can_set_db_type_by_type
    @db.add_parameter(@cmd, :type => :expected)
    
    assert_equal :expected, @cmd.parameters.first.db_type
  end
  
  def test_can_set_db_type_by_db_type
    @db.add_parameter(@cmd, :db_type => :expected)
    
    assert_equal :expected, @cmd.parameters.first.db_type
  end
  
  def test_can_set_direction
    @db.add_parameter(@cmd, :direction => :expected)
    
    assert_equal :expected, @cmd.parameters.first.direction
  end
end
