class CartsController < ApplicationController

  def show 
    cart_products = session[:shopping_cart][current_store.id]
    if cart_products.empty?
      @shopping_cart = []
    else
      @shopping_cart = cart_products.collect{|k,v| [Product.unscoped.find(k), v]}
    end
  end

  def update
    product = Product.find(params[:product])
    
    if params[:quantity] == "1"  
      session[:shopping_cart][current_store.id][product.id] += 1 
    end
    if params[:subtract] == "1"
      session[:shopping_cart][current_store.id][product.id] -= 1 
    end
    if params[:add] == "1"
      session[:shopping_cart][current_store.id][product.id] += 1 
    end

    redirect_to :back, notice: "item added to cart"
  end

  def destroy
    product = Product.find(params[:product])
    session[:shopping_cart][current_store.id].delete(product.id)
    redirect_to carts_path, notice: "Your cart was successfully cleared."
  end
end
