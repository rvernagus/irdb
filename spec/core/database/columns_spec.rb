class System::DBNull; end

class CLRString
  def initialize(value)
    @value = value
  end
  
  def to_s
    @value
  end
end

describe Database, "columns" do
  before :each do
    provider = FakeProvider.new
    
    connection = mock("Connection")
    connection.
      should_receive(:connection_string=).
      with("connection string")
    connection.
      should_receive(:state).
      and_return(System::Data::ConnectionState.closed, System::Data::ConnectionState.open)
    connection.
      should_receive(:open)
    connection.
      should_receive(:close)
    connection.
      should_receive(:get_schema).
      with("Columns").
      and_return(FakeDataTable.new(
        {
          "TABLE_NAME"     => CLRString.new("table1"),
          "COLUMN_NAME"    => CLRString.new("col1"),
          "COLUMN_DEFAULT" => "default1",
          "DATA_TYPE"      => CLRString.new("type1"),
          "IS_NULLABLE"    => CLRString.new("YES")
        },
        {
          "TABLE_NAME"     => CLRString.new("table1"),
          "COLUMN_NAME"    => CLRString.new("col2"),
          "COLUMN_DEFAULT" => System::DBNull.new,
          "DATA_TYPE"      => CLRString.new("type2"),
          "IS_NULLABLE"    => CLRString.new("NO")
        },
        {
          "TABLE_NAME"     => CLRString.new("table2"),
          "COLUMN_NAME"    => CLRString.new("col3"),
          "COLUMN_DEFAULT" => "default3",
          "DATA_TYPE"      => CLRString.new("type3"),
          "IS_NULLABLE"    => CLRString.new("YES")
        }
      ))
      
    provider.connection = connection
    @db = Database.new(provider, "connection string")
  end
  
  def result(table_name)
    @db.columns(table_name)
  end
  
  it "should return the expected number of columns" do
    result("table1").length.should == 2
  end
  
  it "should allow for case-insentivity in table name" do
    result("TABLE1").length.should == 2
  end

  it "should convert COLUMN_NAME to String" do
    result("table1").first[:name].should == "col1"
  end

  it "should set COLUMN_DEFAULT to expected" do
    result("table1").first[:default].should == "default1"
  end

  it "should convert COLUMN_DEFAULT to nil if DBNull" do
    result("table1").last[:default].should be_nil
  end

  it "should convert DATA_TYPE to string" do
    result("table1").first[:type].should == "type1"
  end

  it "should convert IS_NULLABLE to string and set to true if 'YES'" do
    result("table1").first[:nullable?].should be_true
  end

  it "should convert IS_NULLABLE to string and set to false if 'NO'" do
    result("table1").last[:nullable?].should be_false
  end
end
