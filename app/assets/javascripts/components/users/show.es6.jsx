const UserShow = React.createClass({
  getInitialState() {
    return { tabOne: true };
  },

  setTab(opts) {
    this.setState({tabOne: opts.isTabOne});
  },

  tabClasses(inactive) {
    return `nav-item ${inactive && 'inactive'}`
  },

  render() {
    const { activeSubscriptions, inactiveSubscriptions, user } = this.props;
    const { tabOne } = this.state;

    return (
      <div>
        <div id="page-title">
          <h1>{`${user.firstName}'s Account`}</h1>
        </div>

        <div className="user-show-container">
          <div className="Grid user-nav">
            <span className="Grid-cell border-cell u-size1of2">
              <div
                className={this.tabClasses(!tabOne)}
                onClick={this.setTab.bind(this, { isTabOne: true })}
              >
                Subscriptions
              </div>
            </span>
            <span className="Grid-cell u-size1of2">
              <div
                className={this.tabClasses(tabOne)}
                onClick={this.setTab.bind(this, { isTabOne: false })}
              >
                Account Info
              </div>
            </span>
          </div>

          <section className="user-main">
            {tabOne &&
              <Subscriptions
                activeSubscriptions={activeSubscriptions}
                inactiveSubscriptions={inactiveSubscriptions}
              />
            }
            {!tabOne &&
              <AccountInfo user={user} />
            }
          </section>
        </div>
      </div>
    );
  }
});
