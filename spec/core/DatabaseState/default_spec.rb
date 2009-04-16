describe DatabaseState, "in default state" do
  before :each do
    @state = DatabaseState.new
  end
  
  it "should not be connected" do
    @state.connected?.should be_false
  end
end
