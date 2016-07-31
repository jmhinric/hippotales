const ChildNew = React.createClass({
  render() {
    const { child } = this.props;

    return (
      <section>
        <div className="Grid">
          <div className="Grid-cell u-size1of2">
          <input
            type="text"
            name="child_first_name"
            id="child_first_name"
            placeholder="* Child's first name"
            className="border-right"
            required="required"
          />
          </div>
          <div className="Grid-cell u-size1of2">
            <input
              type="text"
              name="child_last_name"
              id="child_last_name"
              placeholder="* Child's last name"
              className="float-right"
              required="required"
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
              />
            </div>
          </div>
          <div className="Grid-cell u-size1of2">
            <select
              name="child_gender"
              id="child_gender"
              className="float-right"
              required="required"
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
