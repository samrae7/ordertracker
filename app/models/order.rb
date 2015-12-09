class DateValidator < ActiveModel::Validator
  def validate(record)
    if record.order_date < Date.today
      record.errors[:base] << "This date is in the past"
    end
  end
end

class Order < ActiveRecord::Base
  has_many :line_items
  has_many :products, :through => :line_items
  validates_with DateValidator
end
