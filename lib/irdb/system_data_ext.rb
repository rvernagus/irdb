module System::Data
  class DataRow
    def to_hash
      table.columns.inject({}) { |h, col| h[col.to_s] = self[col]; h }
    end
    alias :to_h :to_hash
    
    def method_missing(symbol, *args, &block)
      col_name = symbol.to_s
      super unless table.columns.contains(col_name)
      self[col_name]
    end
  end
  
  class DataTable
    def to_array
      rows.collect { |row| row.to_hash }
    end
    alias :to_a :to_array
  end
end