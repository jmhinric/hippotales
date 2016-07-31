const SubscriptionNew = React.createClass({
  componentDidMount() {
    new HT.Join().init();
    // clear Braintree iframes to prevent duplicates
    $("#payment-form iframe").remove();
  },

  stateOptions() {
    return this.props.states.map((state, i) => {
      return <option key={i} value={state[1]}>{state[0]}</option>;
    });

  },

  render() {
    const {
      subscription,
      user,
      child,
      cost
    } = this.props;

    return (
      <div>
        <div id="page-title"><h1>Join</h1></div>

        <div className="subscription-container">
          <section className="form-section">
            <h3>CHOOSE SUBSCRIPTION:</h3>
            <div className="Grid subscription-options">
              <div className="Grid-cell u-size1of3 subscription-option">
                <div className="subscription-info">
                  <span>
                    <span className="month-number">1 Month</span> Subscription
                  </span>
                  <span>
                    {`$${cost.oneMonth} / month`}
                  </span>
                </div>
                <input type="radio" name="subscription_type" id="subscription_type-1" value="1" />
              </div>
              <div className="Grid-cell u-size1of3 subscription-option">
                <div className="subscription-info">
                  <span>
                    <span className="month-number">3 Month</span> Subscription
                  </span>
                  <span>
                    {`$${cost.threeMonth} / month`}
                  </span>
                </div>
                <input type="radio" name="subscription_type" id="subscription_type-3" value="3" />
              </div>
              <div className="Grid-cell u-size1of3 subscription-option">
                <div className="subscription-info">
                  <span>
                    <span className="month-number">6 Month</span> Subscription
                  </span>
                  <span>
                    {`$${cost.sixMonth} / month`}
                  </span>
                </div>
                <input type="radio" name="subscription_type" id="subscription_type-6" value="6" />
              </div>
            </div>
          </section>

          <section className="form-section">
            <h3>CHILD INFO</h3>
            <div className="Grid">
              <div className="Grid-cell u-size1of2">
              <input
                type="text"
                name="child_first_name"
                id="child_first_name"
                placeholder="* Child's first name"
                className="border-right"
                required="required"
              />
              </div>
              <div className="Grid-cell u-size1of2">
                <input
                  type="text"
                  name="child_last_name"
                  id="child_last_name"
                  placeholder="* Child's last name"
                  className="float-right"
                  required="required"
                />
              </div>
              <div className="Grid-cell child-birthday u-size1of2">
                <div className="Grid-cell u-size4of4">
                  <input
                    type="date"
                    name="child_birthday"
                    id="child_birthday"
                    className="border-right"
                    placeholder="mm/dd/yyyy"
                  />
                </div>
              </div>
              <div className="Grid-cell u-size1of2">
                <select
                  name="child_gender"
                  id="child_gender"
                  className="float-right"
                  required="required"
                >
                  <option value="">* Gender</option>
                  <option value="Boy">Boy</option>
                  <option value="Girl">Girl</option>
                </select>
              </div>
            </div>

            <div className="Grid">
              <div className="Grid-cell u-size1of2">
                <input
                  type="text"
                  name="subscription_address_line1"
                  id="subscription_address_line1"
                  className="border-right"
                  placeholder="* Shipping Address Line 1"
                  required="required"
                />
              </div>
              <div className="Grid-cell u-size1of2">
                <input
                  type="text"
                  name="subscription_address_line2"
                  id="subscription_address_line2"
                  className="float-right"
                  placeholder="  Shipping Address Line 2"
                />
              </div>
              <div className="Grid-cell u-size1of3">
                <input
                  type="text"
                  name="subscription_city"
                  id="subscription_city"
                  className="border-right"
                  placeholder="* City"
                  required="required"
                />
              </div>
              <div className="Grid-cell u-size1of3">
                <select
                  name="subscription_state"
                  id="subscription_state"
                  className="border-right"
                  required="required"
                >
                  {this.stateOptions()}
                </select>
              </div>
              <div className="Grid-cell u-size1of3">
                <input
                  type="text"
                  name="subscription_zip"
                  id="subscription_zip"
                  placeholder="* Zip Code"
                  className="float-right"
                  required="required"
                />
              </div>
            </div>

            <h4>Is this a gift?</h4>
            <div className="checkbox gift-message-checkbox">
              <input type="checkbox" name="is_gift" id="is_gift" value="false" />
              <label className="is-gift">Yes! Send as a gift!</label>
            </div>

            <div className="gift-message hidden">
              <textarea name="gift_message" id="gift_message" placeholder="Gift message (optional)">
              </textarea>
            </div>
          </section>

          <section className="form-section">
            <h3>ACCOUNT INFORMATION</h3>
            <div className="Grid">
              <div className="Grid-cell u-size1of2">
                <input
                  type="text"
                  name="user_first_name"
                  id="user_first_name"
                  className="border-right"
                  placeholder="* First name"
                  required="required"
                />
              </div>
              <div className="Grid-cell u-size1of2">
                <input
                  type="text"
                  name="user_last_name"
                  id="user_last_name"
                  className="float-right"
                  placeholder="* Last name"
                  required="required"
                />
              </div>
              <div className="Grid-cell u-size1of2">
                <input
                  type="password"
                  name="password"
                  id="password"
                  className="border-right"
                  placeholder="* Password"
                  required="required"
                />
              </div>
              <div className="Grid-cell u-size1of2">
                <input
                  type="password"
                  name="password_confirmation"
                  id="password_confirmation"
                  placeholder="* Re-type password"
                  className="float-right"
                  required="required"
                />
              </div>
              <div className="Grid-cell u-size1of2">
                <input
                  type="email"
                  name="email"
                  id="email"
                  pattern="[^@]+@[^@]+.[a-zA-Z]{2,}"
                  className="border-right"
                  placeholder="* Email"
                  required="required"
                />
              </div>
              <div className="Grid-cell u-size1of2">
                <input
                  className="float-right"
                  placeholder="  Phone (xxx) xxx-xxxx"
                  type="text"
                  name="phone[]"
                  id="phone_"
                  maxLength="14"
                  autoComplete="off"
                />
              </div>
            </div>

            <div className="checkbox billing-address-checkbox">
              <input
                type="checkbox"
                name="same_billing_address"
                id="same_billing_address"
                value="false"
              />
              <label className="same-billing-address">
                Same as shipping address
              </label>
            </div>

            <div className="Grid billing-address">
              <div className="Grid-cell u-size1of2">
                <input
                  type="text"
                  name="user_address_line1"
                  id="user_address_line1"
                  className="border-right"
                  placeholder="* Billing Address Line 1"
                  required="required"
                />
              </div>
              <div className="Grid-cell u-size1of2">
                <input
                  type="text"
                  name="user_address_line2"
                  id="user_address_line2"
                  className="float-right"
                  placeholder="Billing Address Line 2"
                />
              </div>
              <div className="Grid-cell u-size1of3">
                <input
                  type="text"
                  name="user_city"
                  id="user_city"
                  className="border-right"
                  placeholder="* City"
                  required="required"
                />
              </div>
              <div className="Grid-cell u-size1of3">
                <select
                  name="user_state"
                  id="user_state"
                  className="border-right"
                  required="required"
                >
                  {this.stateOptions()}
                </select>
              </div>
              <div className="Grid-cell u-size1of3">
                <input
                  type="text"
                  name="user_zip"
                  id="user_zip"
                  placeholder="* Zip Code"
                  className="float-right"
                  required="required"
                />
              </div>
            </div>
          </section>

          <h3 className="section-label">PAYMENT</h3>
          <form id="checkout" method="post" action="/checkout">
            <div id="payment-form"></div>
            <div className="flash">
            </div>

            <div className="checkbox terms-conditions-checkbox">
              <input type="checkbox" name="terms_conditions" id="terms_conditions" value="false" />
              <label>
                I agree to the <span className="terms-link">Terms and Conditions</span>
              </label>
            </div>
            <input type="submit" className="button" value="Review Order" />
          </form>
        </div>
      </div>
    );
  }
});
