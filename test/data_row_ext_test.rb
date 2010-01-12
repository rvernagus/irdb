require File.join(File.dirname(__FILE__), 'test_helper')

class DataRowExtensions < Test::Unit::TestCase
  context 'to_hash' do
    setup do
      @table = System::Data::DataTable.new
    end
    
    context 'when table has no columns' do
      setup do
        @result = @table.new_row.to_hash
      end
      
      should 'returns empty hash' do
        assert_equal({}, @result)
      end
    end
    
    context 'when table has columns' do
      setup do
        @table.columns.add 'col1', String.to_clr_type
        @table.columns.add 'col2', String.to_clr_type
      
        row = @table.new_row
        row['col1'] = 'value1'
        row['col2'] = 'value2'
        @result = row.to_hash
      end
      
      should 'returns hash of column names and values' do
        assert_equal @result['col1'], 'value1'
        assert_equal @result['col2'], 'value2'
      end
    end
  end
end
