class DateValidator < ActiveModel::Validator
  def validate(record)
    if record.order_date < Date.today
      record.errors[:base] << "This date is in the past"
    end
  end
end