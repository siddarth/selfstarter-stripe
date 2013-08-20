class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   "email"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end
end
