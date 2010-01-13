module System::Data
  class DataRow
    def to_hash
      table.columns.inject({}) { |h, col| h[col.to_s] = self[col]; h }
    end
    alias :to_h :to_hash
  end
end