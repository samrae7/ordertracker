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
      post do
        Order.create!({
          customer_name:params[:customer_name],
          status:"DRAFT",
          order_date:params[:order_date],
        })
      end

      #UPDATE

      desc "update an order status"
      params do
        requires :id, type: String
        requires :status, type:String
      end
      put ':id' do
        if ((params[:status]==="PLACED" && Order.find(params[:id]).status==="DRAFT" && Order.find(params[:id]).line_items.length >= 1) || (Order.find(params[:id]).status==="DRAFT" && params[:status]==="CANCELLED")) then
        Order.find(params[:id]).update({
          status:params[:status]})
        else
          return "Error: you cannot change the status of an order that does not have any line items"
        end
      end
    end
  end
end