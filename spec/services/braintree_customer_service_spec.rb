require 'rails_helper'

RSpec.describe BraintreeCustomerService do
  describe '#execute' do
    let(:user) { create :user }
    let(:subscription) { create :subscription, user: user }
    let(:service) { described_class.new(subscription: subscription, nonce: nonce) }

    shared_examples 'a customer creator' do
      it 'creates a Customer' do
        expect { service.execute }.to change { Customer.count }.by 1
        expect(Customer.count).to eq 1

        customer = Customer.first
        expect(customer.user_id).to eq(user.id)
        expect(user.customer).to eq(customer)

        expect(customer.first_name).to eq(user.first_name)
        expect(customer.last_name).to eq(user.last_name)
        expect(customer.email).to eq(user.email)
        expect(customer.braintree_customer_id).to be
      end
    end

    context 'credit card' do
      let(:nonce) { 'fake-valid-visa-nonce' }

      it_behaves_like 'a customer creator'

      it 'creates a PaymentMethod' do
        expect { service.execute }.to change { PaymentMethod.count }.by 1
        expect(PaymentMethod.count).to eq 1

        customer = Customer.first
        payment_method = PaymentMethod.first

        expect(payment_method.payment_method).to eq('credit_card')

        expect(subscription.payment_method).to eq(payment_method)
        expect(payment_method.subscriptions).to include(subscription)

        expect(payment_method.customer_id).to eq(customer.id)
        expect(customer.payment_methods).to include(payment_method)

        expect(payment_method.image_url).to be
        expect(payment_method.token).to be
        expect(payment_method.active).to eq(true)
        expect(payment_method.card_type).to be
        # expect(payment_method.cardholder_name).to be
        expect(payment_method.expiration_month).to be
        expect(payment_method.expiration_year).to be
        expect(payment_method.last_4).to be

        expect(payment_method.email).not_to be
      end
    end

    context 'paypal' do
      let(:nonce) { 'fake-paypal-future-nonce' }

      it_behaves_like 'a customer creator'

      it 'creates a PaymentMethod' do
        expect { service.execute }.to change { PaymentMethod.count }.by 1
        expect(PaymentMethod.count).to eq 1

        customer = Customer.first
        payment_method = PaymentMethod.first

        expect(payment_method.payment_method).to eq('paypal')

        expect(subscription.payment_method).to eq(payment_method)
        expect(payment_method.subscriptions).to include(subscription)

        expect(payment_method.customer_id).to eq(customer.id)
        expect(customer.payment_methods).to include(payment_method)

        expect(payment_method.image_url).to be
        expect(payment_method.token).to be
        expect(payment_method.active).to eq(true)
        expect(payment_method.email).to be

        expect(payment_method.card_type).not_to be
        expect(payment_method.cardholder_name).not_to be
        expect(payment_method.expiration_month).not_to be
        expect(payment_method.expiration_year).not_to be
        expect(payment_method.last_4).not_to be
      end
    end
  end
end
