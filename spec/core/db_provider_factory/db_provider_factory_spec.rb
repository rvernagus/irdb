DbProviderFactories = System::Data::Common::DbProviderFactories

describe DbProviderFactory, "all" do
  before :each do
    @factory = DbProviderFactory.new
  end
  
  it "should call .NET DbProviderFactories method" do
    expected = Object.new
    DbProviderFactories.factory = expected
    provider = @factory.create_provider("provider name")
    
    DbProviderFactories.provider_name.should == "provider name"
    provider.should == expected
  end
  
  it "should add create_data_table method" do
    provider = @factory.create_provider("provider name")
    
    provider.respond_to?(:create_data_table).should be_true
  end
  
  it "should return expected object from create_data_table method" do
    provider = @factory.create_provider("provider name")
    result = provider.create_data_table
    
    result.class.should == FakeDataTable
  end
end
