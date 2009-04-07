require "test/unit"
require "lib/irdb"
require "helpers/fake_provider"

class DatabaseTest < Test::Unit::TestCase
  def test_stores_provider
    provider = FakeProvider.new
    @db = Database.new(provider, "connection string")
    
    assert_equal provider, @db.provider
  end
end