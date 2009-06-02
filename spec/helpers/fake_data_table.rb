class FakeDataTable < System::Data::DataTable
  def initialize(*data)
    data.first.each do |k, v|
      columns.add(k, v.get_type)
    end
    
    data.each do |d|
      rows.add(*d.values)
    end
  end
end
