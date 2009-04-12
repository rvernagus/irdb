class TestException < System::Data::Common::DbException; end

describe Database, "connections on Oracle" do
  extend OracleHelper
  
  before :each do
    @db = get_database
  end
  
  it "should pass connection to block in Open state" do
    @db.connection do |c|
      c.state.should == System::Data::ConnectionState.Open
    end
  end
  
  it "should close the connection at the end of the block" do
    connection = nil
    @db.connection { |c| connection = c }
    
    connection.state.should == System::Data::ConnectionState.Closed
  end
  
  it "should ensure that the connection is closed on error" do
    connection = nil
    lambda {
      @db.connection do |c|
        connection = c
        raise TestException
      end
    }.should raise_error(TestException)
    
    connection.state.should ==  System::Data::ConnectionState.Closed
  end
end
