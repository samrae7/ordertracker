class API < Grape::API
  prefix 'api'
  version 'v1', using: :path, cascade: false
  mount Producttracker::Data
  mount Ordertracker::Data
  mount Lineitemtracker::Data
end