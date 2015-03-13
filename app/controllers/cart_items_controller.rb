class CartItemsController < ApplicationController
  def create
    item = Item.find_by(parameterized_name: params[:item])
    @cart.add_item(item)

    session[:cart] = @cart.data
    flash[:notice] =
    "You have #{pluralize(@cart.item_quantity(item), item.name)} in your cart."
    redirect_to :back
  end

  def index
    @cart
  end

  def destroy
    item = Item.find(params[:id])
    @cart.remove_item(item)

    session[:cart] = @cart.data
    flash[:notice] = "The item has been removed from your cart."
    redirect_to cart_path
  end
end
