class FakeReader
  def initialize(max_reads)
    @num_reads = 0
    @max_reads = max_reads
    @disposed = false
  end
  
  def read
    @num_reads += 1
    @num_reads <= @max_reads
  end
  
  def dispose
    @disposed = true
  end
  
  def disposed?
    @disposed
  end
end
