# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

prices = %w{1.09 2.44 3.66 4.99 5.99 6.00 7.25 8.45 9.99 10.00 11.00 12.67 13.89 14.99}
names = %w{scissors hairbrush comb mirror tweezers stamps toothpaste shampoo conditioner doll ball string dye belt}

names.each {|item| Product.create(name:item, net_price:0, vat: 20)}

Product.all.each_with_index { |item, index| item.update({net_price:prices[index]}) }

Product.all.each_with_index {|product, index| product.orders << Order.create(customer_name:"Joe Bloggs "+ index.to_s, order_date:Date.today, status:"DRAFT")}

LineItem.all.each do |line_item|
  line_item.update({quantity: 4})
  line_item.updateTotals
  line_item.updateProductName
end

Order.all.each {|order| order.updateTotals}

