const GiftMessage = React.createClass({
  getInitialState() {
    return {
      isGift: false
    };
  },

  handleChange() {
    const { isGift } = this.state;
    this.props.subscription.isGift = !isGift;
    this.setState({ isGift: !isGift });
  },

  handleMessageChange(e) {
    this.props.subscription.giftMessage = e.target.value;
  },

  render() {
    const { isGift } = this.state;

    return (
      <section>
        <h4>Is this a gift?</h4>
        <div className="checkbox">
          <input type="checkbox" onChange={this.handleChange} />
          <label className="is-gift">Yes! Send as a gift!</label>
        </div>

        {isGift &&
          <div className="gift-message">
            <textarea placeholder="Gift message (optional)" onChange={this.handleMessageChange}>
            </textarea>
          </div>
        }
      </section>
    );
  }
});
