require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter           => 'irdb',
  :provider          => 'System.Data.SqlClient',
  :connection_string => 'Data Source=(local);Initial Catalog=test;Integrated Security=True'
)

class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.text   :info
    end
  end
  
  def self.down
    drop_table :people
  end
end

CreatePeople.down
CreatePeople.up

class Person < ActiveRecord::Base
  
end

Person.create(:first_name => 'Ray', :last_name => 'Vernagus')

#class Product < ActiveRecord::Base
#  set_primary_key "ProductID"
#end
#
#class Customer < ActiveRecord::Base
#  set_primary_key "CustomerID"
#  has_many :orders, :finder_sql => 'SELECT * FROM Orders WHERE CustomerID = \'#{id}\''
#end
#
#class Order < ActiveRecord::Base
#  set_primary_key "OrderID"
#end
#
#class OrderDetail < ActiveRecord::Base
#  set_table_name "[Order Details]"
#  belongs_to :product, :foreign_key => "[ProductID]"
#  belongs_to :order, :foreign_key => "[OrderID]"
#end

#puts "\nall\n------------------"
#puts "Found #{Product.all.length} Products!"
#
#puts "\nfind(:first)\n----------------"
#first = Product.find(:first)
#p first
#p "--> #{first.ProductName}: #{first.UnitPrice}"
#p Product.find(:last)
#
#puts "\nfind(:all, conditions)\n-------------------"
#p Product.find(:all, :conditions => [
#  "ProductID = :id and UnitPrice = :price",
#  { :id => 54, :price => 7.45 }])
#p Product.find(:all, :conditions => { :UnitPrice => 7.45 })
#
#puts "\nfind(id)\n----------------------"
#p Product.find(1)
#
#puts "\nsave\n---------------------"
#new_product = Product.new('ProductName' => 'Beer', 'SupplierID' => 1,
#                          'CategoryID' => 1, 'QuantityPerUnit' => '1',
#                          'UnitPrice' => 18.00, 'UnitsInStock' => 39,
#                          'UnitsOnOrder' => 0, 'ReorderLevel' => 10,
#                          'Discontinued' => 0)
#p new_product
#p new_product.new_record?
#p new_product.save
#p new_product
#
#
#puts "\ndelete\n-------------------"
#id = new_product.ProductID
#new_product.delete
#Product.find(id) rescue puts "Product was deleted!! =)"
#
#
#p Order.find(:all, :conditions => [
#  "OrderDate > :order_date",
#  { :order_date => '5/1/1998' }
#])
#
#detail = OrderDetail.find(:first)
#p detail
#p detail.product
#p detail.order
#
#customer = Customer.find(:first)
#p customer.orders
