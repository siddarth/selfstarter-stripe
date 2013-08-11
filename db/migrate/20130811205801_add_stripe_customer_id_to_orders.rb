class AddStripeCustomerIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :stripe_customer_id, :string
  end
end
