const SubscriptionTypeSelect = React.createClass({
  getInitialState() {
    return {
      selected: undefined
    };
  },

  handleClick(cost) {
    this.setState({ selected: cost });
    this.props.subscription.subscriptionCostId = cost.id;
  },

  render() {
    const { costs, subscription } = this.props;

    return (
      <section>
        <div className="Grid subscription-options">
          {costs.map(cost => {
            let classNames = "Grid-cell u-size1of3 subscription-option"
            if (this.state.selected === cost) classNames = `${classNames} selected`;

            return (
              <div key={cost.id} className={classNames} onClick={this.handleClick.bind(this, cost)}>
                <div className="subscription-info">
                  <span><span className="month-number">{cost.description}</span> Subscription</span>
                  <span>{cost.perMonth}</span>
                </div>
              </div>
            )
           })}
        </div>
      </section>
    );
  }
});
