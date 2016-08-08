const ChildNew = React.createClass({
  getInitialState() {
    return {
      selectedGender: '',
      selectedBirthday: ''
    };
  },

  handleBirthdayChange(e) {
    const val = e.target.value;
    this.props.child.birthday = val;
    this.setState({ selectedBirthday: val });
  },

  handleGenderChange(e) {
    const val = e.target.value;
    this.props.child.gender = val && val.toLowerCase();
    this.setState({ selectedGender: val });
  },

  render() {
    const { child } = this.props;
    const genderStyle = this.state.selectedGender === '' ? {color: 'rgb(173, 173, 173)'} : {};
    const birthdayStyle = this.state.selectedBirthday === '' ? {color: 'rgb(173, 173, 173)'} : {};

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
              <input
                style={birthdayStyle}
                ref="birthdayInput"
                type="date"
                placeholder="mm/dd/yyyy"
                className="border-right"
                onChange={this.handleBirthdayChange}
              />
            </div>
          </div>
          <div className="Grid-cell u-size1of2">
            <select
              style={genderStyle}
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
