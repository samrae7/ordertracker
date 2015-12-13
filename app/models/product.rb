class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, :through => :line_items
  validates :name, uniqueness: true

  after_commit :update_associated_resources, on: [:update]
 
  def update_associated_resources
    if (self.line_items.length >= 1) then
      self.line_items.each do |item|
        item.updateProductName
        item.updateTotals
        if (self.orders.length >= 1) then
          self.orders.each do |order|
          order.updateTotals
          end
        end
      end
    end
  end

end
