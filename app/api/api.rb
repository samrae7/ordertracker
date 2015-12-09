class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  mount Producttracker::Data
  mount Ordertracker::Data
  mount Lineitemtracker::Data
end