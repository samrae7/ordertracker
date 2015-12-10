module Producttracker
  class Data < Grape::API

    resource :product_data do
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
        Product.find(params[:id]).destroy!
      end

      
      #UPDATE
      desc "update a prodct name"
      params do
        requires :id, type: String
        requires :name, type:String
      end
      put ':id' do
        Product.find(params[:id]).update({
          name:params[:name]
        })
      end

    end

  end
end