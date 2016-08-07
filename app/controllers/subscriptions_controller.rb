# == Schema Information
#
# Table name: subscriptions
#
#  id                   :uuid             not null, primary key
#  is_gift              :boolean          default(FALSE)
#  gift_message         :text
#  address_line1        :string
#  address_line2        :string
#  city                 :string
#  state                :string
#  zip                  :string
#  user_id              :uuid
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  subscription_cost_id :uuid
#  active               :boolean          default(TRUE)
#  status               :integer          default(0)
#  payment_method_id    :uuid
#

class SubscriptionsController < ApplicationController
  include Constants

  attr_reader :user, :child, :subscription

  def new
    @user = current_user || User.as_new
    @child = Child.as_new
    @subscription = Subscription.as_new
    @states = US_STATES
    @costs = SubscriptionPlan.current.subscription_costs.map do |cost|
      React.camelize_props(cost.as_new)
    end
  end

  # TODO separate current_user case into an update action

  # TODO:
  #   - check if child already exists in user.children
  #     - allow user to select from pre-existing children in the UI
  #   - check if payment method already exists in user.payment_methods
  #     - allow user to select from pre-existing payment methods in the UI
  def create
    ActiveRecord::Base.transaction do
      begin
        @user = current_user || User.create!(user_params)
        @child = Child.create!(child_params)
        @subscription = Subscription.new(subscription_params.merge(user: user, children: [child]))

        BraintreeCustomerService.new(
          subscription: subscription,
          nonce: payment_params[:nonce]
        ).execute

        BraintreePaymentService.new(
          subscription: subscription,
          amount: subscription.cost_per_month
        ).execute_first_payment

        session[:user_id] = @user.id

        render js: "window.location = '/users/#{@user.id}'"
      rescue => e
        render json: { error: e.message }, status: :not_acceptable
        raise ActiveRecord::Rollback
      end
    end
  end

  def client_token
    render json: { client_token: Braintree::ClientToken.generate }
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :password,
      :password_confirmation,
      :email,
      :phone,
      :address_line1,
      :address_line2,
      :city,
      :state,
      :zip
    )
  end

  def child_params
    params.require(:child).permit(:first_name, :last_name, :birthday, :gender)
  end

  def subscription_params
    params.require(:subscription).permit(
      :subscription_cost_id,
      :type,
      :address_line1,
      :address_line2,
      :city,
      :state,
      :zip,
      :is_gift,
      :gift_message
    )
  end

  def payment_params
    params.permit(:nonce, :payment_type)
  end
end
