module System
  class DBNull
  end
end

describe Database, "columns" do
  before :each do
    @provider = FakeProvider.new
    
    @connection = mock("Connection")
    @connection.
      should_receive(:connection_string=).
      with("connection string")
    @connection.
      should_receive(:state).
      and_return(System::Data::ConnectionState.closed, System::Data::ConnectionState.open)
    @connection.
      should_receive(:open)
    @connection.
      should_receive(:close)
    @connection.
      should_receive(:get_schema).
      with("Columns").
      and_return(FakeDataTable.new(
        {
          "TABLE_NAME"     => "table1",
          "COLUMN_NAME"    => "col1",
          "COLUMN_DEFAULT" => "default1",
          "DATA_TYPE"      => "type1",
          "IS_NULLABLE"    => "YES"
        },
        {
          "TABLE_NAME"     => "table1",
          "COLUMN_NAME"    => "col2",
          "COLUMN_DEFAULT" => "default2",
          "DATA_TYPE"      => "type2",
          "IS_NULLABLE"    => "NO"
        },
        {
          "TABLE_NAME"     => "table2",
          "COLUMN_NAME"    => "col3",
          "COLUMN_DEFAULT" => "default3",
          "DATA_TYPE"      => "type3",
          "IS_NULLABLE"    => "YES"
        }
      ))
      
    @provider.connection = @connection
    @db = Database.new(@provider, "connection string")
  end
  
  it "should return the expected number of columns" do
    @db.columns("table1").length.should == 2
  end
  
  it "should allow for case-insentivity in table name" do
    @db.columns("TABLE1").length.should == 2
  end
  
  it "should map the expected values from the Columns schema to a hash array" do
    result = @db.columns "table1"
    
    result.first[:name].should == "col1"
    result.first[:default].should == "default1"
    result.first[:type].should == "type1"
    result.first[:nullable?].should == true
    
    result.last[:name].should == "col2"
    result.last[:default].should == "default2"
    result.last[:type].should == "type2"
    result.last[:nullable?].should == false
  end
end
