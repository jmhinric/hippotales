const Subscription = React.createClass({
  // propTypes: {
    // subscription: PropTypes.instanceOf(Subscription)
    // duration: PropTypes.number,
    // costPerMonth: PropTypes.number,
    // isGift: PropTypes.bool,
    // giftMessage: PropTypes.string,
    // addressLine1: PropTypes.string,
    // addressLine2: PropTypes.string,
    // city: PropTypes.string,
    // state: PropTypes.string,
    // zip: PropTypes.string,
    // createdAt: PropTypes.instanceOf(Date)
  // },

  render() {
    const timezone = moment.tz.guess();
    const timezoneLabel = moment().tz(timezone).format('zz');
    const { subscription } = this.props;
    const {
      createdAt,
      costPerMonth,
      duration,
      childNames
    } = subscription;

    return (
      <div className="subscription-show">
        <div className="subscription-details">
          <ul className="Grid">
            <li className="Grid-cell u-size1of4">
              <div className="details-header">ORDERED ON</div>
              <span className="details-data">
                {`${moment(createdAt).tz(timezone).format('LLL')} ${timezoneLabel}`}
              </span>
            </li>
            <li className="Grid-cell u-size1of4">
              <div className="details-header">NEXT SHIPMENT ON</div>
              <span className="details-data">-</span>
            </li>
            <li className="Grid-cell u-size1of4">
              <div className="details-header">COST</div>
              <span className="details-data">${costPerMonth} / month</span>
            </li>
            <li className="Grid-cell u-size1of4">
              <div className="details-header">SUBSCRIPTION CYCLE</div>
              <span className="details-data">{duration} months</span>
            </li>
          </ul>
          <div className="Grid-cell u-size1of3"></div>
        </div>

        <div className="subscription-info">
          <div className="Grid">
            <div className="Grid-cell u-size2of3">
              <div className="child-info">
                <h3>{childNames}</h3>
              </div>
              <div className="small-info">
                <span className="bold">Paid with: </span>
              </div>
              <div className="small-info">Shipments remaining:</div>
            </div>

            <div className="Grid-cell u-size1of12">
            </div>
            <div className="Grid-cell u-size1of4">
              <div className="subscription-button button">Extend Subscription</div>
              <div className="subscription-button button">Add Child</div>
              <div className="subscription-button button button-yellow">Suspend Subscription</div>
            </div>
          </div>
        </div>
      </div>
    );
  }
});
