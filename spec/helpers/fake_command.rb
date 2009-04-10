class FakeCommand
  attr_accessor :connection, :command_text, :query_result,
                :transaction, :parameters
  
  def initialize
    self.query_result = {}
    self.parameters = []
    def parameters.add(item)
      self << item
    end
  end
  
  def execute_non_query
    query_result[:non_query]
  end
  
  def execute_scalar
    query_result[:scalar]
  end
  
  def execute_reader
    query_result[:reader]
  end
  
  def execute_table
    query_result[:table]
  end
end
