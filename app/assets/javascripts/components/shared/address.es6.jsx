const Address = React.createClass({
  stateOptions() {
    return this.props.states.map((state, i) => {
      return <option key={i} value={state[1]}>{state[0]}</option>;
    });
  },

  handleStateChange(e) {
    this.props.model.state = e.target.value;
  },

  render() {
    const { model, descriptor } = this.props;
    const placeholderDescriptor = descriptor ? `${descriptor} ` : ''

    return (
      <section>
        <div className="Grid">
          <div className="Grid-cell u-size1of2">
            <TextInput
              model={model}
              attribute="addressLine1"
              placeholder={`* ${placeholderDescriptor}Address Line 1`}
              classNames="border-right"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <TextInput
              model={model}
              attribute="addressLine2"
              placeholder={`* ${placeholderDescriptor}Address Line 2`}
              classNames="float-right"
            />
          </div>
          <div className="Grid-cell u-size1of3">
            <TextInput
              model={model}
              attribute="city"
              placeholder={`* ${placeholderDescriptor}City`}
              classNames="border-right"
            />
          </div>
          <div className="Grid-cell u-size1of3">
            <select className="border-right" onChange={this.handleStateChange}>
              {this.stateOptions()}
            </select>
          </div>
          <div className="Grid-cell u-size1of3">
            <TextInput
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
