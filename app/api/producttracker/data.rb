module Producttracker
  class Data < Grape::API

    resource :products do
      #INDEX
      desc "List all Products"
      get do
        Product.all
      end

      #SHOW
      desc "show a product by id"
      params do
        requires :id, type: String
      end
      get ':id' do
        Product.find(params[:id])
      end

      #CREATE
      desc "create a new product"
      ## This takes care of parameter validation
      params do
        requires :name, type: String
        requires :net_price, type:Float
        optional :vat, type: Float, default: 20
      end
      ## This takes care of creating product
      post do
        Product.create!({
          name:params[:name],
          net_price:params[:net_price],
          vat:params[:vat]
        })
      end

      #DELETE
      desc "delete a product"
      params do
        requires :id, type: String
      end

      delete ':id' do
        product = Product.find(params[:id])
        unless product.orders.length >= 1
          product.destroy!
        end
      end

      
      #UPDATE
      desc "update a product"
      params do
        requires :id, type: String
        optional :name, type:String
        optional :net_price, type:Float
      end
      
      put ':id' do
        product = Product.find(params[:id])
        net_price = params[:net_price] ? params[:net_price] : product.net_price
        name = params[:name] ? params[:name] : product.name
        product.update({
          name:name,
          net_price:net_price
        })
        if (product.line_items.length >= 1) then
          product.line_items.each do |item|
            item.updateProduct
            item.updateTotals
            if (product.orders.length >= 1) then
              product.orders.each do |order|
                order.updateTotal
              end
            end
          end
        return product
        end
      end

    end

  end
end