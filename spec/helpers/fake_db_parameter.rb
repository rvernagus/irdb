class FakeDbParameter < System::Data::Common::DbParameter
  attr_accessor :value, :db_type, :parameter_name,
                :direction, :size, :source_column
end
