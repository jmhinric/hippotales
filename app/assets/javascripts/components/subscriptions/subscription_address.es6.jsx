const SubscriptionAddress = React.createClass({
  propTypes: {
    stateOptions: React.PropTypes.func.isRequired
  },

  render() {
    const { subscription, stateOptions } = this.props;

    return (
      <section>
        <div className="Grid">
          <div className="Grid-cell u-size1of2">
            <input
              type="text"
              name="subscription_address_line1"
              id="subscription_address_line1"
              className="border-right"
              placeholder="* Shipping Address Line 1"
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
            />
          </div>
          <div className="Grid-cell u-size1of3">
            <select
              name="subscription_state"
              id="subscription_state"
              className="border-right"
            >
              {stateOptions()}
            </select>
          </div>
          <div className="Grid-cell u-size1of3">
            <input
              type="text"
              name="subscription_zip"
              id="subscription_zip"
              placeholder="* Zip Code"
              className="float-right"
            />
          </div>
        </div>
      </section>
    );
  }
});
