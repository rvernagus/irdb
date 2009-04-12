describe Database, "commands on SQL Server" do
  extend SqlServerHelper
  
  before :each do
    @db = get_database
  end
  
  it "should have expected connection" do
    @db.connection do |c|
      @db.command("SELECT 'Death Knight'") do |cmd|
        cmd.connection.should == c
      end
    end
  end

  it "should have open connection" do
    @db.connection do |c|
      @db.command("SELECT 'Death Knight'") do |cmd|
        cmd.connection.state.should == System::Data::ConnectionState.open
      end
    end
  end

  it "should allow multiple commands within single command block" do
    @db.connection do |c|
      @db.command("SELECT 'Death Knight'") do |cmd|
        result = cmd.execute_scalar
        result.should == "Death Knight"
      end
      
      @db.command("SELECT 'Shaman'") do |cmd|
        result = cmd.execute_scalar
        result.should == "Shaman"
      end
    end
  end
  
  it "should allow command to execute with an active transaction" do
    @db.connection do |c|
      @db.transaction do |t|
        @db.command("SELECT 'Death Knight'") do |cmd|
          result = cmd.execute_scalar
          result.should == "Death Knight"
        end
      end
    end
  end
end
