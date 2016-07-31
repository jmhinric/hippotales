const UserAddress = React.createClass({
  propTypes: {
    stateOptions: React.PropTypes.func.isRequired
  },

  render() {
    const { user, stateOptions } = this.props;

    return (
      <section>
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
              {stateOptions()}
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
    );
  }
});
