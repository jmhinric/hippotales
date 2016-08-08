const Address = React.createClass({
  getInitialState() {
    return {
      selectedState: ''
    };
  },

  stateOptions() {
    return this.props.states.map((state, i) => {
      return <option key={i} value={state[1]}>{state[0]}</option>;
    });
  },

  handleStateChange(e) {
    this.props.model.state = e.target.value;
    this.setState({ selectedState: e.target.value });
  },

  render() {
    const { model, descriptor } = this.props;
    const placeholderDescriptor = descriptor ? `${descriptor} ` : ''
    const style = this.state.selectedState === '' ? {color: 'rgb(173, 173, 173)'} : {};

    return (
      <section>
        <div className="Grid">
          <div className="Grid-cell u-size1of2">
            <ModelInput
              model={model}
              attribute="addressLine1"
              placeholder={`* ${placeholderDescriptor}Address Line 1`}
              classNames="border-right"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <ModelInput
              model={model}
              attribute="addressLine2"
              placeholder={`* ${placeholderDescriptor}Address Line 2`}
              classNames="float-right"
            />
          </div>
          <div className="Grid-cell u-size1of3">
            <ModelInput
              model={model}
              attribute="city"
              placeholder={`* ${placeholderDescriptor}City`}
              classNames="border-right"
            />
          </div>
          <div className="Grid-cell u-size1of3">
            <select style={style} className="border-right" onChange={this.handleStateChange}>
              {this.stateOptions()}
            </select>
          </div>
          <div className="Grid-cell u-size1of3">
            <ModelInput
              model={model}
              attribute="zip"
              placeholder={`* ${placeholderDescriptor}Zip Code`}
              classNames="float-right"
            />
          </div>
        </div>
      </section>
    );
  }
});
