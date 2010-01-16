require File.join(File.dirname(__FILE__), 'test_helper')

class DataTableExtensions < Test::Unit::TestCase
  context 'An empty DataTable' do
    setup do
      @table = System::Data::DataTable.new
    end
    
    should 'convert to an empty Array' do
      assert_equal [], @table.to_a
    end
    
    should 'have to_a alias' do
      assert_equal @table.method(:to_array), @table.method(:to_a)
    end
  end
  
  context 'A DataTable containing data' do
    setup do
      @table = System::Data::DataTable.new
      @table.columns.add 'col1', String.to_clr_type
      @table.columns.add 'col2', String.to_clr_type
    
      row = @table.new_row
      row['col1'] = 'value1'
      row['col2'] = 'value2'
      @table.rows.add row
    end
    
    should 'convert to an Array of row Hashes' do
      assert_equal [{'col1' => 'value1', 'col2' => 'value2'}], @table.to_array
    end
  end
end
