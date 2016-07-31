const SubscriptionTypeSelect = React.createClass({
  render() {
    const { cost } = this.props;

    return (
      <section>
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
    );
  }
});
