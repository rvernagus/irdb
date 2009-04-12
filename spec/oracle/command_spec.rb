describe Database, "commands on Oracle" do
  extend OracleHelper
  
  before :each do
    @db = get_database
  end
  
  it "should have expected connection" do
    @db.connection do |c|
      @db.command("SELECT 'Death Knight' FROM dual") do |cmd|
        cmd.connection.should == c
      end
    end
  end

  it "should have open connection" do
    @db.connection do |c|
      @db.command("SELECT 'Death Knight' FROM dual") do |cmd|
        cmd.connection.state.should == System::Data::ConnectionState.open
      end
    end
  end

  it "should allow multiple commands within single command block" do
    @db.connection do |c|
      @db.command("SELECT 'Death Knight' FROM dual") do |cmd|
        result = cmd.execute_scalar
        result.should == "Death Knight"
      end
      
      @db.command("SELECT 'Shaman' FROM dual") do |cmd|
        result = cmd.execute_scalar
        result.should == "Shaman"
      end
    end
  end
  
  it "should allow command to execute with an active transaction" do
    @db.connection do |c|
      @db.transaction do |t|
        @db.command("SELECT 'Death Knight' FROM dual") do |cmd|
          result = cmd.execute_scalar
          result.should == "Death Knight"
        end
      end
    end
  end
end
