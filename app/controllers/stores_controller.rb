class StoresController < ApplicationController

    def show
        @store = Store.find(params[:id])
    end

    def new
        @store = Store.new
    end

    def create
        @store = Store.new(store_params)
        @store.user_id = current_user.id
        if @store.save
            flash[:notice] = "Store created successfully!"
            redirect_to store_path(@store)
        else
            flash[:error] = @store.errors.full_messages.join(' /n')
            redirect_to new_store_path
        end
    end

    private

    def store_params
        params.require(:store).permit(:name, :category, :id)
    end
end
