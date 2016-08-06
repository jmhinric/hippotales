const ChildNew = React.createClass({
  handleFirstNameChange(e) {
    this.props.child.firstName = e.target.value;
  },

  handleLastNameChange(e) {
    this.props.child.lastName = e.target.value;
  },

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
            <input
              type="text"
              name="child_first_name"
              placeholder="* Child's first name"
              className="border-right"
              onChange={this.handleFirstNameChange}
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <input
              type="text"
              name="child_last_name"
              placeholder="* Child's last name"
              className="float-right"
              onChange={this.handleLastNameChange}
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
