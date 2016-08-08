const SubscriptionNew = React.createClass({
  getInitialState() {
    return {
      hasSubmitted: false,
      nonce: undefined
    };
  },

  componentWillMount() {
    const { user, child, subscription } = this.props;

    HT.subscription = subscription;
    HT.child = child;
    HT.user = user;

    $.get("/client_token")
      .done(result => {
        braintree.setup(result["client_token"], "dropin", {
          container: "payment-form",
          onPaymentMethodReceived: this.paymentNonceReceived
        });
      })
      .fail(() => console.log("Failed to get Braintree client token."));
  },

  paymentNonceReceived(result) {
    this.setState({ nonce: result, hasSubmitted: true });

    // if (this.noErrors()) {
    //   this.renderConfirmModalDetails();
    //   $(".confirm-subscription-wrapper").toggleClass("hidden");
    //   $(".subscription-container").toggleClass("hidden");
    // }
    // this.errorListenersSetup();
    this.sendConfirmedSubscription();
  },

  sendConfirmedSubscription() {
    // this.toggleConfirmModal();
    // var self = this;
    // if (this.noErrors() && this.nonce) {
      $.post( "/subscriptions", this.checkoutParams())
        .fail(error => {
          console.log("There was a problem somewhere: " + error.responseText);
          // self.renderError(self.SERVER_JOIN_ERROR_MESSAGE);
        });
    // }
    // else {
    //   this.renderError(this.FAILED_TO_SUBMIT_MESSAGE);
    // }
  },

  checkoutParams() {
    const nonce = "&nonce=" + this.state.nonce["nonce"];
    var paymentType = "&payment_type=" + this.state.nonce["type"]
    return this.serializeParams() + nonce + paymentType;
    // return $(".subscription-form").serialize() + nonce + paymentType;
  },

  serializeParams() {
    const { user, subscription, child } = this.props;
    return $.param({
      user: this.toSnakeCase(user),
      subscription: this.toSnakeCase(subscription),
      child: this.toSnakeCase(child)
    });
  },

  toSnakeCase(model) {
    return _.object(_.map(model, (value, key) => {
      return [key.replace(/([A-Z])/g, cap => "_"+cap.toLowerCase()), value];
    }));
  },

  render() {
    const { subscription, user, child, states, costs } = this.props;

    return (
      <div>
        <div id="page-title"><h1>{user.id ? 'New Subscription' : 'Join'}</h1></div>

        <div className="subscription-container">
          <div className="form-section">
            <h3>CHOOSE SUBSCRIPTION:</h3>
            <SubscriptionTypeSelect costs={costs} subscription={subscription} />
          </div>

          <div className="form-section">
            <h3>CHILD INFO</h3>
            <ChildNew child={child} />
            <Address
              model={subscription}
              descriptor="Subscription"
              states={states}
            />
            <GiftMessage subscription={subscription} />
          </div>

          {!user.id &&
            <div className="form-section">
              <h3>ACCOUNT INFORMATION</h3>
              <UserNew user={user} stateOptions={this.stateOptions} states={states} />
              <Address
                model={user}
                descriptor="Billing"
                states={states}
              />
            </div>
          }

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
