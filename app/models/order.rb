class Order < ActiveRecord::Base
  # Address details.
  attr_accessible :address_line1, :address_line2, :city, :state, :country, :zip, :phone
  # Shipping/billing details.
  attr_accessible :order_number, :shipping, :tracking_number, :stripe_customer_id
  # Product details.
  attr_accessible :name, :price
  attr_readonly :uuid

  before_validation :generate_uuid!, :on => :create
  belongs_to :user
  self.primary_key = 'uuid'

  def self.generate
    o = self.new
    o.order_number = Order.next_order_number || 1
    o
  end

  def self.next_order_number
  	Order.order("order_number DESC").limit(1).first.order_number.to_i + 1 if Order.count > 0
  end

  def generate_uuid!
  	self.uuid = SecureRandom.hex(16)
  end

  # Implement these three methods to
  def self.goal
    Settings.project_goal
  end

  def self.percent
    (Order.current.to_f / Order.goal.to_f) * 100.to_f
  end

  # See what it looks like when you have some backers! Drop in a number instead of Order.count
  def self.current
    Order.count
  end

  def self.revenue
    Order.current.to_f * Settings.price
  end

  validates_presence_of :name, :price, :user_id
end
