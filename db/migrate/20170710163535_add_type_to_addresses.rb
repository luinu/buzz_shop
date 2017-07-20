class AddTypeToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :type, :string
  end
end
