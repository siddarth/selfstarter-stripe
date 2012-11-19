Rails.configuration.stripe = {
  :publishable_key_test => ENV['PUBLISHABLE_KEY_TEST'],
  :secret_key_test      => ENV['SECRET_KEY_TEST'],
  :publishable_key      => ENV['PUBLISHABLE_KEY'],
  :secret_key           => ENV['SECRET_KEY']
}

if Settings.stripe_payments_mode == 'test'
  Stripe.api_key = Rails.configuration.stripe[:secret_key_test]
elsif Settings.stripe_payments_mode == 'live'
  Stripe.api_key = Rails.configuration.stripe[:secret_key]
else
  raise "Stripe payments mode (live v. test) is not set in settings.yml."
end
