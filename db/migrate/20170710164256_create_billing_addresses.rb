class CreateBillingAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :billing_addresses do |t|

      t.timestamps
    end
  end
end
