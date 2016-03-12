# This class creates a Braintree::Customer and Braintree::PaymentMethod and corresponding
#   Customer and PaymentMethod objects.
# All object associations are also set between Customer, PaymentMethod, User, and Subscription.

class BraintreeCustomerService

  attr_reader :subscription, :nonce, :user, :customer

  def initialize(subscription:, nonce:)
    @subscription = subscription
    @nonce = nonce
    @user = subscription.user
  end

  def execute
    create_customer
    subscription.update!(payment_method: create_payment_method)
  end

  private

  def create_customer
    braintree_customer = create_braintree_customer

    @customer = Customer.create!(
      braintree_customer_id: braintree_customer.id,
      first_name: braintree_customer.first_name,
      last_name: braintree_customer.last_name,
      email: braintree_customer.email,
      user_id: user.id
    )
  end

  def create_braintree_customer
    result = Braintree::Customer.create(
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email
    )

    if result.success?
      return result.customer
    else
      fail "Failure in Braintree::Customer.create: #{result.errors}"
    end
  end

  def create_payment_method
    attrs = payment_method_attrs(create_braintree_payment_method)
    PaymentMethod.create!(attrs)
  end

  def create_braintree_payment_method
    result = Braintree::PaymentMethod.create(
      customer_id: customer.braintree_customer_id,
      payment_method_nonce: nonce,
      options: { verify_card: true }
    )

    if result.success?
      result.payment_method
    else
      fail "Failure in Braintree::PaymentMethod.create: #{result.errors}"
    end
  end

  def payment_method_attrs(payment_method)
    if payment_method.class == Braintree::CreditCard
      attrs = {
        payment_method: :credit_card,
        card_type: payment_method.card_type,
        cardholder_name: payment_method.cardholder_name,
        expiration_month: payment_method.expiration_month,
        expiration_year: payment_method.expiration_year,
        last_4: payment_method.last_4
      }
    elsif payment_method.class == Braintree::PayPalAccount
      attrs = {
        payment_method: :paypal,
        email: payment_method.email
      }
    end

    attrs.merge(
      image_url: payment_method.image_url,
      token: payment_method.token,
      customer_id: customer.id,
      active: true
    )
  end
end


# result.success?
# #=> false
# result.transaction.status
# #=> "processor_declined"
# result.transaction.processor_response_code
# #=> "2001"
# result.transaction.processor_response_text
# #=> "Insufficient Funds"
