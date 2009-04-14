describe Database, "add_parameter" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @cmd = @provider.command
  end
  
  def param
    @cmd.parameters.length.should == 1
    @cmd.parameters.first
  end

  it "should add a parameter to the command" do
    @db.add_parameter(@cmd)
    
    @cmd.parameters.length.should == 1
  end
  
  it "should set the parameter name to :name" do
    @db.add_parameter(@cmd, :name => :expected)
    
    param.parameter_name.should == :expected
  end
  
  it "should set the parameter name to :parameter_name" do
    @db.add_parameter(@cmd, :parameter_name => :expected)
    
    param.parameter_name.should == :expected
  end
  
  it "should set the parameter value to :value" do
    @db.add_parameter(@cmd, :value => :expected)
    
    param.value.should == :expected
  end
  
  it "should set db_type to :type" do
    @db.add_parameter(@cmd, :type => :expected)
    
    param.db_type.should == :expected
  end
  
  it "should set db_type to :db_type" do
    @db.add_parameter(@cmd, :db_type => :expected)
    
    param.db_type.should == :expected
  end
  
  it "should not set db_type when not specified" do
    @provider.parameter.db_type = :initial_value
    @db.add_parameter(@cmd)
    
    param.db_type.should == :initial_value
  end
  
  it "should set direction to :direction" do
    @db.add_parameter(@cmd, :direction => :expected)
    
    param.direction.should == :expected
  end
  
  it "should not set direction when not specified" do
    @provider.parameter.direction = :initial_value
    @db.add_parameter(@cmd)
    
    param.direction.should == :initial_value
  end
  
  it "should set size to :size" do
    @db.add_parameter(@cmd, :size => :expected)
    
    param.size.should == :expected
  end
  
  it "should not set size when not specified" do
    @provider.parameter.size = :initial_value
    @db.add_parameter(@cmd)
    
    param.size.should == :initial_value
  end
  
  it "should set source_column to :source_column" do
    @db.add_parameter(@cmd, :source_column => :expected)
    
    param.source_column.should == :expected
  end
end
