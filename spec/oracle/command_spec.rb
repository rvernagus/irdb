describe Database, "commands on SQL Server" do
  extend OracleHelper
  
  before :each do
    @db = get_database
  end
  
  it "should return expected scalar value" do
    @db.connection do |c|
      @db.command("SELECT 'Death Knight' FROM dual") do |cmd|
        result = cmd.execute_scalar
        result.should == "Death Knight"
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
