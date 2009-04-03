require "test/unit"
require "lib/netdb"

class TableTest < Test::Unit::TestCase
  def setup
    @db = NetDb::Database.new("System.Data.SqlClient",
                              "Data Source=.\\sqlexpress;Initial Catalog=ActiveRecordTest;Integrated Security=True;MultipleActiveResultSets=True")
  end
  
  def test_with_sql
    result = @db.execute_table(:sql => "select 'Ray'")
    assert_equal 1, result.rows.count
  end
  
  def test_with_block
    result = @db.execute_table do |cmd|
      name = @db.create_parameter(:name => "first_name", :value => "Ray".to_string)
      cmd.parameters.add name
      cmd.command_text = "select @first_name"
    end
    assert_equal 1, result.rows.count
  end
end
