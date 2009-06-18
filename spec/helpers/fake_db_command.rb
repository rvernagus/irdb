class FakeDbCommand < System::Data::Common::DbCommand
  attr_accessor :connection, :command_text,
                :transaction, :parameters

  def initialize
    @parameters = []
    def @parameters.add(item)
      self << item
    end
  end
end
