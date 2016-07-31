const AccountInfo = React.createClass({
  render() {
    const { user } = this.props;
    const { displayName, email, phone } = user;

    return (
      <div>
        <h2>Your Account Info</h2>
        <div className="user-account-info">
          <div>{displayName}</div>
          <div>{email}</div>
          <div>{phone}</div>
          <DisplayAddress entity={user} />
        </div>
      </div>
    );
  }
});
