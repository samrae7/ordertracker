class DateNotPast < Grape::Validations::Base
  def validate_param!(attr_name, params)
    unless params[attr_name] >= Date.today
      fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "date must not be in the past"
    end
  end
end