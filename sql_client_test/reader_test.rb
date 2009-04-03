require "test/unit"
require "lib/netdb"

class ReaderTest < Test::Unit::TestCase
  def setup
    @db = NetDb::Database.new("System.Data.SqlClient",
                              "Data Source=.\\sqlexpress;Initial Catalog=ActiveRecordTest;Integrated Security=True;MultipleActiveResultSets=True")
  end
  
  def test_with_block
    result = @db.execute_reader(:sql => "select 'Ray'") do |rdr|
      assert_equal "Ray", rdr.get_value(0)
    end
  end
end
