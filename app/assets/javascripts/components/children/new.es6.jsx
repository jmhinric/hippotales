const ChildNew = React.createClass({
  handleGenderChange(e) {
    const val = e.target.value;
    this.props.child.gender = val && val.toLowerCase();
  },

  render() {
    const { child } = this.props;

    return (
      <section>
        <div className="Grid">
          <div className="Grid-cell u-size1of2">
            <ModelInput
              model={child}
              attribute="firstName"
              placeholder="* Child's first name"
              classNames="border-right"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <ModelInput
              model={child}
              attribute="lastName"
              placeholder="* Child's last name"
              classNames="float-right"
            />
          </div>
          <div className="Grid-cell child-birthday u-size1of2">
            <div className="Grid-cell u-size4of4">
              <ModelInput
                type="date"
                model={child}
                attribute="birthday"
                placeholder="mm/dd/yyyy"
                classNames="border-right"
              />
            </div>
          </div>
          <div className="Grid-cell u-size1of2">
            <select
              name="child_gender"
              id="child_gender"
              className="float-right"
              onChange={this.handleGenderChange}
            >
              <option value="">* Gender</option>
              <option value="Boy">Boy</option>
              <option value="Girl">Girl</option>
            </select>
          </div>
        </div>
      </section>
    );
  }
});
