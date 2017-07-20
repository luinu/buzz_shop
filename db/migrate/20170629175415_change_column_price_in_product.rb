class ChangeColumnPriceInProduct < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :price, :decimal, null: false
  end
end
