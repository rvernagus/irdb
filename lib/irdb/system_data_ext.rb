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
end