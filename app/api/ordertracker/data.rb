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
          status:params[:status],
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
        Order.find(params[:id]).update({
          status:params[:status]
        })
      end
    end
  end
end