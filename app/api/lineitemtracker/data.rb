module Lineitemtracker

  class Data < Grape::API
    require_relative '../../../lib/api/validations/product_quantity'

    resource :line_items do
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
        requires :quantity, type: Integer, minimum_quantity: true
        requires :product_id, type: Integer
        requires :order_id, type: Integer
      end
      ## This takes care of creating line item
      post do
        order = Order.find(params[:order_id])
        product = Product.find(params[:product_id])
        if order.status==="DRAFT"
          line_item = LineItem.create!({
            quantity:params[:quantity],
            product_id:params[:product_id], 
            order_id:params[:order_id],
            product_name:product.name
          })
          line_item.updateTotals
          order.updateTotals
        else
          return "Line item cannot be created unless the order has DRAFT status"
        end

      end
    
      #DELETE
      desc "delete a line item"
      params do
        requires :id, type: String
      end

      delete ':id' do
        line_item = LineItem.find(params[:id])
        # order_id = line_item.order_id
        order = line_item.order
        if order.status === "DRAFT"
          line_item.destroy!
          order.updateTotals
        else
          return "Line item cannot be deleted as it belongs to an order that is not in DRAFT status"
        end
      end

      #UPDATE
      desc "update a line item quantity and/or which order it belongs to"
      params do
        requires :id, type: String
        optional :quantity, type: Integer, minimum_quantity: true
        optional :order_id, type: Integer
        optional :product_id, type: Integer
      end
      put ':id' do
        line_item = LineItem.find(params[:id])
        order_id = (params[:order_id] ? params[:order_id] : line_item.order_id)
        product_id = params[:product_id] ? params[:product_id] : line_item.product_id
        if !Order.find(order_id) then
          return "No such order"
        elsif !Product.find(product_id) then
          return "No such product"
        elsif Order.find(order_id).status === "DRAFT"  then
          line_item.update({
          quantity:(params[:quantity] ? params[:quantity]: line_item.quantity),
          order_id:order_id,
          product_id:product_id
          })
          line_item.updateProductName
          line_item.updateTotals
          Order.find(order_id).updateTotals
        else
          return "Line item cannot be changed as it belongs to an order that is not in DRAFT status"
        end
      end
    end
  end
end