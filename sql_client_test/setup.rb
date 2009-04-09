require "test/unit"
require "lib/irdb"

module Setup
  def setup
    provider_factory = IRDb::DbProviderFactory.new
    provider = provider_factory.create_provider("System.Data.SqlClient")
    cstr = "Data Source=.\\sqlexpress;Initial Catalog=IRDbTest;Integrated Security=True;"

    @db = IRDb::Database.new(provider, cstr)
  end
end
