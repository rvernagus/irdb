require "test/unit"
require "lib/irdb"
require "System.Data"

class SqlTransactionTest < Test::Unit::TestCase
  def setup
    provider_factory = IRDb::DbProviderFactory.new
    provider = provider_factory.create_provider("System.Data.SqlClient")
    cstr = "Data Source=.\\sqlexpress;Initial Catalog=IRDbTest;Integrated Security=True;"

    @db = IRDb::Database.new(provider, cstr)
  end
  
  def test_created_successfully
    @db.connection do |c|
      @db.transaction do |t|
        assert_not_nil t
      end
    end
  end
end
