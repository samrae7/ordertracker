class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def updateTotals
    product = Product.find(self.product_id)

    net_total = product.net_price * self.quantity.round(2)
    gross_total = (product.net_price * self.quantity * (product.vat + 100) /100).round(2)
    self.update({net_total:net_total, gross_total:gross_total})
  end

  def updateProduct
    self.update({product_name:self.product.name})
  end
end
