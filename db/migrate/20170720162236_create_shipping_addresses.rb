class CreateShippingAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :shipping_addresses do |t|

      t.timestamps
    end
  end
end
