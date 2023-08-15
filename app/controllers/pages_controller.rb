class PagesController < ApplicationController
  def home
    @products = Product.all
  end

  def view
    @purchases = Purchase.where(user_id: current_user.id)
  end
end
