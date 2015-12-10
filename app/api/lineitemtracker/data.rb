module Lineitemtracker

  class Data < Grape::API
    require_relative '../../../lib/api/validations/product_quantity'

    resource :line_data do
      #INDEX
      desc "List all line items"
      get do
        LineItem.all
      end

      #SHOW
      desc "show a line item by id"
      params do
        requires :id, type: String
      end
      get ':id' do
        LineItem.find(params[:id])
      end

      #CREATE
      desc "create a new line item"
      ## This takes care of parameter validation
      params do
        requires :quantity, minimum_quantity: true
        requires :product_id, type: Integer
        requires :order_id, type: Integer
      end
      ## This takes care of creating line item
      post do
        LineItem.create!({
          quantity:params[:quantity],
          product_id:params[:product_id], 
          order_id:params[:order_id],
          product_name:Product.find(params[:product_id]).name,
          net_total:Product.find(params[:product_id]).net_price * params[:quantity],
          gross_total:Product.find(params[:product_id]).net_price * params[:quantity]* (Product.find(params[:product_id]).vat + 100) /100
        })
        order = Order.find(params[:order_id])
        order.updateTotal
      end

      #DELETE
      desc "delete a line item"
      params do
        requires :id, type: String
      end

      delete ':id' do
        LineItem.find(params[:id]).destroy!
      end

      
      #UPDATE
      desc "update a line item quantity"
      params do
        requires :id, type: String
        optional :quantity, type:String
        optional :order_id, type: Integer
      end
      put ':id' do
        if Order.find(LineItem.find(params[:id]).order_id).status === "DRAFT" then
          LineItem.find(params[:id]).update({
          quantity:params[:quantity], order_id:params[:order_id]
        })
        else
          return "Error: line item is part of an order and that order is no longer in DRAFT status, so the line item cannot be changed"
        end
      end

    end
  end
end