class FakeReader
  attr_reader :data
  
  def initialize
    @data = []
    @disposed = false
    @read_init = true
  end
  
  def read
    data.pop unless @read_init
    @read_init = false
    !data.empty?
  end
  
  def dispose
    @disposed = true
  end
  
  def disposed?
    @disposed
  end
end
