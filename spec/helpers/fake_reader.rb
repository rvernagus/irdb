class FakeReader
  attr_reader :data
  
  def initialize
    @data = []
    @disposed = false
  end
  
  def read
    @curr_rec = data.pop
    !@curr_rec.nil?
  end
  
  def field_count
    @curr_rec.to_a.length
  end
  
  def get_name(i)
    @curr_rec.to_a[i][0]
  end
  
  def get_value(i)
    @curr_rec.to_a[i][1]
  end
  
  def dispose
    @disposed = true
  end
  
  def disposed?
    @disposed
  end
end
