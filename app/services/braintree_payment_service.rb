class BraintreePaymentService
  attr_reader :amount, :subscription

  def initialize(amount:, subscription:)
    @amount = amount
    @subscription = subscription
  end

  def execute_first_payment
    # make payment
    # result = BraintreePaymentService.new(amount: amount, subscription: subscription).execute

    sale = make_payment
    # TODO create the Shipment model
    # subscription.set_next_shipping_date
    # shipment.subscriptions << subscription
    subscription.update!(active: true, state: :queued)
    # subscription.payment_histories << create_payment_history(subscription, sale)
    # subscription.save
  end

  private

  def make_payment
      # :payment_method_nonce => "fake-valid-visa-nonce"
    braintree_result = Braintree::Transaction.sale(
      amount: amount,
      payment_method_token: subscription.payment_token,
      customer: { id: subscription.braintree_customer_id }
    )

    # TODO: test this
    # return result.success? ? result.sale : fail "Failed Braintree::Transaction.sale"
  end

  def create_payment_history(subscription, result)
    # TODO create the PaymentHistory model

    # PaymentHistory.create!(
    #   subscription: subscription,
    #   amount: result.amount
    # )
  end
end
