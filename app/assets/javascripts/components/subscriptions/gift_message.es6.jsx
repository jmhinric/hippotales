const GiftMessage = React.createClass({
  render() {
    const { subscription } = this.props;

    return (
      <section>
        <h4>Is this a gift?</h4>
        <div className="checkbox gift-message-checkbox">
          <input type="checkbox" name="is_gift" id="is_gift" value="false" />
          <label className="is-gift">Yes! Send as a gift!</label>
        </div>

        <div className="gift-message hidden">
          <textarea name="gift_message" id="gift_message" placeholder="Gift message (optional)">
          </textarea>
        </div>
      </section>
    );
  }
});
