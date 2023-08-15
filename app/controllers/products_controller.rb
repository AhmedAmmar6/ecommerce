class ProductsController < ApplicationController

    before_action :authenticate_user!, only: [:buy]

    def index
        @products = Product.all
    end
    
    def show
        @product = Product.find(params[:id])
    end
    def new
        @store = Store.find(params[:store_id])
        @product = Product.new
    end
    def create
        # binding.break
        @store = Store.find(params[:store_id])
        @product = Product.new(product_params)
        @product.store_id = @store.id
        if @product.save
            flash[:notice] = "Product created successfully!"
            redirect_to store_product_path(@store, @product)
        else
            flash[:error] = @product.errors.full_messages.join(' ')
            redirect_to new_store_product_path
        end
    end

    def buy
        @product = Product.find(params[:id])
        @purchase = Purchase.find_by(user_id: current_user.id, product_id: @product.id)
        puts @purchase
        count = 1
        if @purchase
            if  @product.item_count == 0
                redirect_to store_product_path(@product.store, @product), notice: "Unsufficent Products!"
            else
                new_count = @purchase.count + count
                puts new_count
                @purchase.update(count: new_count)
                new_item_count = @product.item_count - count
                @product.update(item_count: new_item_count)
                puts new_item_count
                redirect_to store_product_path(@product.store, @product), notice: "Product purchased successfully!" 
            end
        else
            if @product.item_count == 0
                redirect_to store_product_path(@product.store, @product), notice: "Unsufficent Products!"
            else
                @purchase = Purchase.new
                @purchase.user_id = current_user.id
                @purchase.product_id = @product.id 
                @purchase.count = 1
                @purchase.save
                new_item_count = @product.item_count - count
                @product.update(item_count: new_item_count)
                redirect_to store_product_path(@product.store, @product), notice: "Product purchased successfully!" 
            end
        end
        # decrease_amount = 1
        # new_item_count = @product.item_count - decrease_amount
        # @product.update(item_count: new_item_count)
        # @purchase = Purchase.new
        # @purchase.user_id = current_user.id
        # @purchase.product_id = @product.id 
        # @purchase.count = 1
        # @purchase.save
        
    end

    private
    def product_params
        params.require(:product).permit(:title, :description, :price, :item_count, :image)
    end
end
