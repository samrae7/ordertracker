class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def updateTotals
    product = Product.find(self.product_id)

    net_total = product.net_price * self.quantity
    gross_total = product.net_price * self.quantity * (product.vat + 100) /100
    self.update({net_total:net_total, gross_total:gross_total})
  end

  def updateProduct
    self.update({product_name:self.product.name})
  end
end
