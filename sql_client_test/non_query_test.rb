require "test/unit"
require "lib/netdb"

class NonQueryTest < Test::Unit::TestCase
  def setup
    @db = NetDb::Database.new("System.Data.SqlClient",
                              "Data Source=.\\sqlexpress;Initial Catalog=ActiveRecordTest;Integrated Security=True;MultipleActiveResultSets=True")
  end
  
  def test_with_block
    result = @db.execute_non_query do |cmd|
      name = @db.create_parameter(:name => "first_name", :value => "Ray".to_string)
      cmd.parameters.add name
      cmd.command_text = "update people set first_name = @first_name where id = 1"
    end
    assert_equal 1, result
  end
  
  def test_with_sql
    result = @db.execute_non_query(:sql => "update people set first_name = 'Ray' where id = 1")
    assert_equal 1, result
  end
end
