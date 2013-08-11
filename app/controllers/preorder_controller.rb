class PreorderController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :ipn

  def index

  end

  def checkout!
    @user = User.find_or_create_by_email!(params[:email])
    redirect_to root_url unless params[:stripe_token]

    # Create a Stripe customer that we can charge later, and
    # attach the customer ID to the User object.
    customer = Stripe::Customer.create(
      :description => "Customer for #{params[:email]}",
      :email => params[:email],
      :card => params[:stripe_token]
    )

    # Create an order for this user.
    @order = Order.generate
    @order.stripe_customer_id = customer.id
    @order.name = Settings.product_name
    @order.price = Settings.price
    @order.user_id = @user.id
    @order.address_line1 = params[:address_line1]
    @order.address_line2 = params[:address_line2]
    @order.city = params[:city]
    @order.state = params[:state]
    @order.phone = params[:phone]
    @order.zip = params[:address_zip]
    @order.country = params[:country]
    @order.save!

    redirect_to :action => :share, :uuid => @order.uuid
  end

  def share
  	@order = Order.find_by_uuid(params[:uuid])
  end
end
