require_relative '../../lib/api/validations/date_not_past'

class Order < ActiveRecord::Base
  has_many :line_items
  has_many :products, :through => :line_items
  validates_with DateValidator

  def updateTotal
    total =  0
    gross = 0

    self.line_items.each do |x|
      total += x.net_total
      gross += x.gross_total
    end  
    self.update({net_total: total, gross_total: gross})
  end

end
