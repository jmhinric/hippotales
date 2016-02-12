let Subscription = React.createClass({
  propTypes: {
    // subscription: React.
    // duration: React.PropTypes.number,
    // costPerMonth: React.PropTypes.number,
    // isGift: React.PropTypes.bool,
    // giftMessage: React.PropTypes.string,
    // addressLine1: React.PropTypes.string,
    // addressLine2: React.PropTypes.string,
    // city: React.PropTypes.string,
    // state: React.PropTypes.string,
    // zip: React.PropTypes.string,
    // createdAt: React.PropTypes.instanceOf(Date)
  },

  render() {
    return (
      <div className="subscription-show">

        <div className="subscription-details">
          <ul className="Grid">
            <li className="Grid-cell u-size1of4">
              <div className="details-header">ORDERED ON</div>
              <span className="details-data">
                {this.props.subscription.created_at}
              </span>
            </li>
            <li className="Grid-cell u-size1of4">
              <div className="details-header">NEXT SHIPMENT ON</div>
              <span className="details-data">-</span>
            </li>
            <li className="Grid-cell u-size1of4">
              <div className="details-header">COST</div>
              <span className="details-data">${this.props.costPerMonth} / month</span>
            </li>
            <li className="Grid-cell u-size1of4">
              <div className="details-header">SUBSCRIPTION CYCLE</div>
              <span className="details-data">{this.props.duration} months</span>
            </li>
          </ul>
          <div className="Grid-cell u-size1of3"></div>
        </div>

        <div className="subscription-info">
          <div className="Grid">
            <div className="Grid-cell u-size2of3">
              <div className="child-info">
                <h3>
                  Bobby (needs to be child names)
                </h3>
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
