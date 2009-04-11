describe Database, "transactions on Oracle" do
  extend OracleHelper
  
  before :each do
    @db = get_database
  end
  
  it "should not be nil" do
    @db.connection do |c|
      @db.transaction do |t|
        t.should_not be_nil
      end
    end
  end
end
