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
      states,
      costs
    } = this.props;

// TODO: extract shared component from SubscriptionAddress and UserAddress
    return (
      <div>
        <div id="page-title"><h1>Join</h1></div>

        <div className="subscription-container">
          <div className="form-section">
            <h3>CHOOSE SUBSCRIPTION:</h3>
            <section>
              <div className="Grid subscription-options">
                {costs.map(cost => {
                  return <SubscriptionTypeSelect cost={cost} subscription={subscription} />;
                 })}
              </div>
            </section>
          </div>

          <div className="form-section">
            <h3>CHILD INFO</h3>
            <ChildNew child={child} />
            <SubscriptionAddress
              subscription={subscription}
              stateOptions={this.stateOptions}
            />
            <GiftMessage subscription={subscription} />
          </div>

          <div className="form-section">
            <h3>ACCOUNT INFORMATION</h3>
            <UserNew user={user} stateOptions={this.stateOptions} states={states} />
            <UserAddress user={user} stateOptions={this.stateOptions} />
          </div>

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
