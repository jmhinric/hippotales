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

  attr_reader :user

  def new
    @user = User.new.as_json(except: [:id, :created_at, :updated_at, :password_digest, :is_admin])
    @child = Child.new.as_json(except: [:id, :created_at, :updated_at])
    @subscription = Subscription.new.as_json(
      except: [:id, :created_at, :updated_at, :active, :status, :payment_method_id, :user_id]
    )
    @states = US_STATES
    @costs = SubscriptionPlan.current.subscription_costs.map do |plan|
      React.camelize_props(plan.as_json(methods: [:description, :per_month]))
    end
  end

  def create
    ActiveRecord::Base.transaction do
      begin
        @user = create_user
        subscription = create_subscription(create_child)

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

  def create_user
    User.create!(
      first_name: user_params[:first_name].downcase,
      last_name: user_params[:last_name].downcase,
      email: user_params[:email].downcase,
      phone: phone,
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation],
      address_line1: address_line(user_params[:address_line1]),
      address_line2: address_line(user_params[:address_line2]),
      city: user_params[:city].downcase,
      state: user_params[:state],
      zip: user_params[:zip]
    )
  end

  def phone
    return unless user_params[:phone]
    user_params[:phone].first.gsub(/[^\d]/, '')
  end

  def child_params
    params.require(:child).permit(
      :first_name,
      :last_name,
      :birthday,
      :gender
    )
  end

  def create_child
    Child.create!(
      first_name: child_params[:first_name].downcase,
      last_name: child_params[:last_name].downcase,
      birthday: child_params[:birthday],
      gender: gender
    )
  end

  def gender
    child_params[:gender].downcase == "boy" ? 1 : 0
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

  def create_subscription(child)
    Subscription.create!(
      subscription_cost_id: subscription_params[:subscription_cost_id],
      is_gift: subscription_params[:is_gift],
      gift_message: subscription_params[:gift_message],
      address_line1: address_line(subscription_params[:address_line1]),
      address_line2: address_line(subscription_params[:address_line2]),
      city: subscription_params[:city].downcase,
      state: subscription_params[:state],
      zip: subscription_params[:zip],
      user: user,
      children: [child]
    )
  end

  def address_line(line)
    line.try(:split, ' ').try(:map, &:downcase).try(:join, ' ')
  end

  def payment_params
    params.permit(:nonce, :payment_type)
  end
end
