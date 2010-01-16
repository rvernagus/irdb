require File.join(File.dirname(__FILE__), 'test_helper')

class DataRowExtensions < Test::Unit::TestCase
  context 'A DataRow with no columns' do
    setup do
      @table = System::Data::DataTable.new
      @row   = @table.new_row
    end

    should 'have to_h alias' do
      assert_equal @row.method(:to_hash), @row.method(:to_h)
    end
      
    should 'convert to empty hash' do
      assert_equal({}, @row.to_h)
    end
  end
  
  context 'A DataRow with columns' do
    setup do
      @table = System::Data::DataTable.new
      @table.columns.add 'col1', String.to_clr_type
      @table.columns.add 'col2', String.to_clr_type
    
      @row = @table.new_row
      @row['col1'] = 'value1'
      @row['col2'] = 'value2'
    end
      
    should 'convert to hash with expected keys' do
      assert @row.to_h.has_key?('col1')
      assert @row.to_h.has_key?('col2')
    end
    
    should 'convert to hash with expected values' do
      assert_equal 'value1', @row.to_h['col1']
      assert_equal 'value2', @row.to_h['col2']
    end
    
    should 'raise NoMethodError when method name does not match a column name' do
      assert_raise NoMethodError do
        @row.col3
      end
    end
    
    should 'return value of column if method name matches column name' do
      assert_equal 'value1', @row.col1
    end
  end
end
