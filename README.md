#Order tracking with Rails and Grape

### Code test Dec 2015

## Setup
- clone repo
- Bundle install
- Rake db:create, Rake db:migrate, Rake db:seed
- Start rails server

##Endpoints
 
###Products
<path_to_localhost>/api/v1/products.json
(GET, POST)
<path_to_localhost>/api/v1/products/:id.json
(GET, PUT, DELETE)

###Line items
<path_to_localhost>/api/v1/line_items.json
(GET, POST)
<path_to_localhost>/api/v1/line_items/:id.json
(GET, PUT, DELETE)

###Order
<<path_to_localhost>>/api/v1/orders.json
(GET, POST)
<<path_to_localhost>>/api/v1/orders/:id.json
(GET, PUT)
