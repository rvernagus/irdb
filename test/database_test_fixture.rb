require "test/unit"
require "lib/irdb"
require "helpers/fake_provider"

module DatabaseTestFixture
  def setup
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @conn = @db.instance_variable_get("@conn")
    @transaction = @provider.connection.transaction
  end
end
