require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter           => 'irdb',
  :provider          => 'System.Data.SqlClient',
  :connection_string => 'Data Source=(local);Initial Catalog=NorthWind;Integrated Security=True'
)

class Product < ActiveRecord::Base
  set_primary_key "ProductID"
end

#puts "\nall\n------------------"
#puts "Found #{Product.all.length} Products!"
#
#puts "\nfind(:first)\n----------------"
#first = Product.find(:first)
#p first
#p "--> #{first.ProductName}: #{first.UnitPrice}"
#
#puts "\nfind(id)\n----------------------"
#p Product.find(1)
#
#puts "\nsave\n---------------------"
new_product = Product.new('ProductName' => 'Beer', 'SupplierID' => 1,
                          'CategoryID' => 1, 'QuantityPerUnit' => '1',
                          'UnitPrice' => 18.00, 'UnitsInStock' => 39,
                          'UnitsOnOrder' => 0, 'ReorderLevel' => 10,
                          'Discontinued' => 0)
p new_product
p new_product.new_record?
p new_product.save
p new_product

puts "\ndelete\n-------------------"
id = new_product.ProductID
new_product.delete
Product.find(id) rescue puts "Product was deleted!! =)"

