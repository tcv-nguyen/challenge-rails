config_file = Rails.root.join("config", "stripe.yml")
stripe_setting = 
  if File.exist?(config_file)
    YAML.load_file(config_file)[Rails.env]
  else
    {}
  end

Stripe.api_key = stripe_setting["key"]

require 'has_stripe'