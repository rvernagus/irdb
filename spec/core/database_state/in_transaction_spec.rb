describe DatabaseState, "in transaction state" do
  before :each do
    @state = DatabaseState.new
    @state.transaction = mock("DbTransaction")
  end
  
  it "should be in a transaction" do
    @state.in_transaction?.should be_true
  end
end
