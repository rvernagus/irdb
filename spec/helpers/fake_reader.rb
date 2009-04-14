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
  
  def field_count
    data.first.to_a.length
  end
  
  def get_name(i)
    data.first.to_a[i][0]
  end
  
  def get_value(i)
    data.first.to_a[i][1]
  end
  
  def dispose
    @disposed = true
  end
  
  def disposed?
    @disposed
  end
end
