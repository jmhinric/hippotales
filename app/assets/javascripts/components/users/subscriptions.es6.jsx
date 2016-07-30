const Subscriptions = React.createClass({
  getInitialState() {
    return { tabOne: true };
  },

  setTab(opts) {
    this.setState({tabOne: opts.isTabOne});
  },

  tabClasses(isInactive) {
    return `nav-item ${isInactive && 'inactive'}`
  },

  render() {
    const { activeSubscriptions, inactiveSubscriptions } = this.props;
    const { tabOne } = this.state;

    return (
      <div>
        <h2>Your Subscriptions</h2>
        <div className="subscription-types">
          <ul>
            <li>
              <span
                className={this.tabClasses(!tabOne)}
                onClick={this.setTab.bind(this, { isTabOne: true })}
              >
                Active
              </span>
            </li>
            <li>
              <span
                className={this.tabClasses(tabOne)}
                onClick={this.setTab.bind(this, { isTabOne: false })}
              >
                History
              </span>
            </li>
          </ul>
        </div>
        <div className="subscriptions">
          {tabOne && <Subscription subscription={activeSubscriptions[0]} /> }
          {!tabOne && <Subscription subscription={inactiveSubscriptions[0]} /> }
        </div>
      </div>
    );
  }
});
