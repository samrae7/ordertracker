class MinimumQuantity < Grape::Validations::Base
  def validate_param!(attr_name, params)
    unless params[attr_name] >= 1
      fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "must be at least one"
    end
  end
end