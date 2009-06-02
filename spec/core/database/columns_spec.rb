require "fake_data_table"

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
    provider.connection._mock.
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
          "COLUMN_DEFAULT" => System::DBNull.value,
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
  
  it "should return a hash of the columns as given by the provider" do
    cols = result("table1").first
    cols["TABLE_NAME"].to_s.should == "table1"
    cols["COLUMN_NAME"].to_s.should == "col1"
    cols["COLUMN_DEFAULT"].to_s.should == "default1"
    cols["DATA_TYPE"].to_s.should == "type1"
    cols["IS_NULLABLE"].to_s.should == "YES"
  end
end
