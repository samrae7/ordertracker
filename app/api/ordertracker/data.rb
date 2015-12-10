module Ordertracker
  class Data < Grape::API

    resource :order_data do
      
      #INDEX
      desc "List all orders"
      get do
        Order.all
      end

      #SHOW
      desc "show an order by id"
      params do
        requires :id, type: String
      end
      get ':id' do
        Order.find(params[:id])
      end

      #CREATE
      desc "create a new order"
      ## This takes care of creating order
      params do
        optional :customer_name
        requires :order_date, type: Date
      end
      post do
        Order.create!({
          customer_name:params[:customer_name],
          status:"DRAFT",
          order_date:params[:order_date],
          net_total:0 ,
          gross_total:0
        })
      end

      #UPDATE

      desc "update an order status"
      params do
        requires :id, type: String
        optional :status, type:String
        optional :customer_name, type: String
      end

      put ':id' do
        # take whole block in the if bracket and make a method for it
        order = Order.find(params[:id])
        if order.status==="DRAFT" then
          if ((params[:status]==="PLACED" && order.line_items.length >= 1) || params[:status]==="CANCELLED") then
            order.update({
            status:params[:status], customer_name:params[:customer_name]})
          elsif !params[:status] then
            order.update({customer_name:params[:customer_name]})
          elsif %w{DRAFT, CANCELLED, PLACED}.exclude? params[:status] then
            return "Not a valid status"
          else
            return "Error: you cannot change the status of an order that does not have any line items"
          end
        else
          return "Error: only orders with DRAFT status can be changed"
        end
      end
    end
  end
end