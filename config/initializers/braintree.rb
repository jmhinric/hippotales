braintree_config = Rails.application.config_for(:braintree)

Braintree::Configuration.environment = braintree_config["environment"]
Braintree::Configuration.merchant_id = braintree_config["merchant_id"]
Braintree::Configuration.public_key = braintree_config["public_key"]
Braintree::Configuration.private_key = braintree_config["private_key"]
