class CartController < ApplicationController
  before_action :check_stock, only: [:finish]
  def show
    @cart = current_cart
  end

  def edit
    @cart = current_cart
    if user_signed_in?
      @user = current_user
      if @user.address.blank?
        @cart.build_address
      else
        @cart.address = @user.address
      end
    else
      @cart.build_address if @cart.address.blank?
    end
  end

  def update
    @cart = current_cart
    if @cart.update_attributes(cart_attributes)
      @cart.update_attribute(:shipping_cost, @cart.shipping_type.cost)
      redirect_to confirmation_cart_path
    else
      render action: :edit
    end
  end

  def confirmation
    @cart = current_cart
  end

  def finish
    @cart = current_cart
    @cart.transition_to :confirmed
    if user_signed_in?
      @cart.user_id = current_user.id
      @cart.save
    end
    remove_from_stock
    session.delete(:order_id)
    flash[:notice] = "Dziękujemy za złożenie zamówienia"
    redirect_to root_path
  end

  def check_stock
    order = current_cart
    order.line_items.each do |line_item|
      product = Product.find(line_item.product_id)
      if product.stock.quantity < line_item.quantity
        line_item.destroy
        flash[:notice] = "Produkt jest niedostępny, został usunięty z koszyka"
        return redirect_to action: :show
      end
    end
  end

  def remove_from_stock
    order = current_cart
    order.line_items.each do |line_item|
      product = Product.find(line_item.product_id)
      product.stock.update_attribute(:quantity, product.stock.substract(line_item.quantity))
    end
  end

  def add_product
    order = current_cart_or_create
    product = Product.find(params[:product_id])
    if item = order.line_items.where(product: product).first
      item.quantity += 1
      item.save
    else
      order.line_items.create product: product,
      quantity: 1,
      unit_price: product.price,
      item_name: product.name
    end
    respond_to do |format|
      format.html do
        redirect_to :back, notice: "Dodano produkt do koszyka"
      end
      format.js do
        flash.now[:notice] = "Dodano produkt do koszyka"
      end
    end
  end

  def remove_product
    order = current_cart_or_create
    product = Product.find(params[:product_id])
    item = order.line_items.where(product: product).first
    if item
      item.destroy
    end
      redirect_to :back, notice: "Usunięto produkt z koszyka"
  end

  private

  def cart_attributes
    params.require(:order).permit(
      :shipping_type_id,
      :comment,
      :user_id,
      :address_attributes => [
        :first_name,
        :last_name,
        :city,
        :zip_code,
        :street,
        :email
      ]
    )
  end
end
