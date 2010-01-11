require File.join(File.dirname(__FILE__), 'test_helper')

class DataRowExtensions < Test::Unit::TestCase
  context 'to_hash' do
    setup do
      table = System::Data::DataTable.new
      table.columns.add 'col1', String.to_clr_type
      table.columns.add 'col2', String.to_clr_type
      
      @row = table.new_row      
    end
    
    should 'returns hash of column names and values' do
      @row['col1'] = 'value1'
      @row['col2'] = 'value2'
      result = @row.to_hash
      
      assert_equal({ 'col1' => 'value1', 'col2' => 'value2' }, result)
    end
  end
end
