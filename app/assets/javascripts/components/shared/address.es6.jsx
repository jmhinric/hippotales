const Address = React.createClass({
  render() {
    const {
      addressLine1,
      addressLine2,
      city,
      state,
      zip
    } = this.props.entity;

    return (
      <div>
        <div>{addressLine1}</div>
        <div>{addressLine2}</div>
        <div>{`${city}, ${state} ${zip}`}</div>
      </div>
    );
  }
});
