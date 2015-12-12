class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, :through => :line_items
  validates :name, uniqueness: true

  after_commit :update_related_resources, on: [:update]
 
  def update_related_resources
    if (self.line_items.length >= 1) then
      self.line_items.each do |item|
        item.updateProduct
        item.updateTotals
        if (self.orders.length >= 1) then
          self.orders.each do |order|
          order.updateTotal
          end
        end
      end
    end
  end

end
