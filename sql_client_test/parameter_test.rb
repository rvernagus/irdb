require "sql_client_test/setup"

class SqlExecuteScalarTest < Test::Unit::TestCase
  include Setup
  
  def test_specify_name_and_value
    result = @db.execute_scalar("SELECT @param") do |cmd|
      @db.add_parameter(cmd, :name => "param", :value => "value".to_string)
    end
    
    assert_equal "value", result
  end
end
