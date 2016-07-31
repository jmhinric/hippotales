const SubscriptionTypeSelect = React.createClass({
  handleClick(cost) {
    this.props.subscription.subscriptionCostId = cost.id;
  },

  render() {
    const { cost, subscription } = this.props;

    return (
      <div className="Grid-cell u-size1of3 subscription-option">
        <div className="subscription-info">
          <span><span className="month-number">{cost.description}</span> Subscription</span>
          <span>{cost.perMonth}</span>
        </div>
        <input type="radio" onClick={this.handleClick.bind(this, cost)} />
      </div>
    );
  }
});
