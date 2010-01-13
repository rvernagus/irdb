require File.join(File.dirname(__FILE__), 'test_helper')

class DataRowExtensions < Test::Unit::TestCase
  context 'to_h' do
    setup do
      @table = System::Data::DataTable.new
    end
    
    should "have to_hash alias" do
      row = @table.new_row
      assert_equal row.method(:to_hash), row.method(:to_h)
    end
    
    context 'when table has no columns' do
      setup do
        @result = @table.new_row.to_hash
      end
      
      should 'returns empty hash' do
        assert_equal @result, {}
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
      
      should 'call to_s on column to get key' do
        assert @result.has_key?('col1')
      end
      
      should 'keys should have expected values' do
        assert_equal 'value1', @result['col1']
        assert_equal 'value2', @result['col2']
      end
    end
  end
end
