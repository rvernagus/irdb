class FakeDataTable
  def initialize(*data)
    @data = data
  end
  
  def rows
    @data
  end
end
