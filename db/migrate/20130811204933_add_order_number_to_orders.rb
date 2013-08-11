class AddOrderNumberToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_number, :integer
  end
end
