#Order tracking with Rails and Grape

### Code test Dec 2015

## Setup
- clone repo
- Bundle install
- Rake db:create, Rake db:migrate, Rake db:seed
- Start rails server

##Endpoints
 
###Products
- pathToLocalHost/api/v1/products.json
(GET, POST)

		POST example:
		{
        "name": "left handed scissors",
        "net_price": 1.19,
        "vat": 20
    	}
    
- pathToLocalHost/api/v1/products/:id.json
(GET, PUT, DELETE)

		NB: cannot update "vat"

###Line items
- pathToLocalHost/api/v1/line_items.json
(GET, POST)
- pathToLocalHost/api/v1/line_items/:id.json
(GET, PUT, DELETE)

###Orders
- pathToLocalHost/api/v1/orders.json
(GET, POST)

		NB: order_date is in format: YYYY-MM-DD 
- pathToLocalHost/api/v1/orders/:id.json
(GET, PUT)

##Spec
Create a Rails/Grape based REST API for an order management system. It only needs to respond to JSON, no HTML necessary. Please incorporate the following requirements:

- (REST) Clients need to be able to create, update and retrieve products
- Each product has a unique name, and a (net) price and a VAT (percentage) which should default to
20%
- Clients should be able to create and update orders
- Orders cannot be deleted
- Each order has an customisable order­date (must not be in the past when created)
- Orders can have multiple line items
- Each line item must belong to an order, reference a product and have a quantity of at least 1
- Clients should be able to create/update/delete line items
- Products cannot be deleted if they were previously ordered
- Orders can have the following statuses: DRAFT, PLACED, CANCELLED
  - Newly created orders must be in DRAFT state
  - An order's status can be raised from DRAFT to PLACED, but only if there is at least one
line item
  - An order's status can change from DRAFT to CANCELLED
  - No other other status changes are permitted, e.g. an order's status can never change back
to DRAFT
  - Changes can be made only to orders in DRAFT state
  - Changes to orders and its line­items should not be permitted once the status is anything but
DRAFT
- Line items, when retrieved, should expose the product name to the API client
- Orders, when retrieved, should expose a net­ and a gross­total (net total + VAT) to the API client
- It's an internal application and there is no authentication/user management/etc required
