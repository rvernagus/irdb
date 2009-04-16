describe DatabaseState, "in connected state" do
  before :each do
    @state = DatabaseState.new
    @state.connection = mock("DbConnection")
  end
  
  it "should be connected" do
    @state.connected?.should be_true
  end
end
