describe Database, "commands on SQL Server" do
  extend SqlServerHelper
  
  before :each do
    @db = get_database
  end
  
  it "should have expected connection" do
    @db.connection do |c|
      cmd = @db.command("SELECT 'Death Knight'")
      cmd.connection.should == c
    end
  end

  it "should have open connection" do
    @db.connection do |c|
      cmd = @db.command("SELECT 'Death Knight'")
      cmd.connection.state.should == System::Data::ConnectionState.open
    end
  end

  it "should allow multiple commands within single connection block" do
    @db.connection do |c|
      cmd = @db.command("SELECT 'Death Knight'")
      result = cmd.execute_scalar
      result.should == "Death Knight"
      
      cmd = @db.command("SELECT 'Shaman'")
      result = cmd.execute_scalar
      result.should == "Shaman"
    end
  end
  
  it "should allow command to execute with an active transaction" do
    @db.transaction do |t|
      cmd = @db.command("SELECT 'Death Knight'")
      result = cmd.execute_scalar
      result.should == "Death Knight"
    end
  end
end
