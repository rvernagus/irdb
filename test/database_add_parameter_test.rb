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
end
