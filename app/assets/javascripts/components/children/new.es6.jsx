const ChildNew = React.createClass({
  handleBirthdayChange(e) {
    this.props.child.birthday = e.target.value;
  },

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
            <TextInput
              model={child}
              attribute="firstName"
              placeholder="* Child's first name"
              classNames="border-right"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <TextInput
              model={child}
              attribute="lastName"
              placeholder="* Child's last name"
              classNames="float-right"
            />
          </div>
          <div className="Grid-cell child-birthday u-size1of2">
            <div className="Grid-cell u-size4of4">
              <input
                type="date"
                name="child_birthday"
                id="child_birthday"
                className="border-right"
                placeholder="mm/dd/yyyy"
                onChange={this.handleBirthdayChange}
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
