const TextInput = React.createClass({
  propTypes: {
    downcase: React.PropTypes.bool,
    classNames: React.PropTypes.string
  },

  handleChange(e) {
    const { model, attribute } = this.props;
    model[attribute] = e.target.value;
  },

  render() {
    const { classNames, placeholder } = this.props;

    return (
      <input
        type="text"
        placeholder={placeholder}
        className={classNames}
        onChange={this.handleChange}
      />
    );
  }
});
