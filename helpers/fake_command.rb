class FakeCommand
  attr_accessor :connection, :command_text, :query_result
  
  def initialize
    self.query_result = {}
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
end
