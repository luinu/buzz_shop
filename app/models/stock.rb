class Stock < ApplicationRecord
  belongs_to :product

  def substract(quantity)
    self.quantity - quantity
  end
  def add_stock(quantity)
    self.quantity + quantity
  end
end
