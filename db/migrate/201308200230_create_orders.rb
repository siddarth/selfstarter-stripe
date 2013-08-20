class CreateOrders < ActiveRecord::Migration
  def change
    create_table "orders", :id => false, :force => true do |t|
      t.string   "address_line1"
      t.string   "address_line2"
      t.string   "city"
      t.string   "state"
      t.string   "country"
      t.string   "zip"
      t.string   "phone"
      t.string   "status"
      t.string   "order_number"
      t.decimal  "shipping"
      t.string   "tracking_number"
      t.string   "stripe_customer_id"
      t.string   "name"
      t.decimal  "price"
      t.string   "uuid"
      t.string   "user_id"
      t.datetime "created_at",         :null => false
      t.datetime "updated_at",         :null => false
    end
  end
end
