const ModelInput = React.createClass({
  propTypes: {
    downcase: React.PropTypes.bool,
    classNames: React.PropTypes.string,
    type: React.PropTypes.string
  },

  getDefaultProps() {
    return {
      type: 'text'
    };
  },

  handleChange(e) {
    const { model, attribute, type } = this.props;
    model[attribute] = e.target.value;
  },

  render() {
    const { classNames, placeholder, type } = this.props;

    return (
      <input
        type={type}
        placeholder={placeholder}
        className={classNames}
        onChange={this.handleChange}
      />
    );
  }
});
