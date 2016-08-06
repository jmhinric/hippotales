const UserNew = React.createClass({
  render() {
    const { user } = this.props;

    return (
      <section>
        <div className="Grid">
          <div className="Grid-cell u-size1of2">
            <input
              type="text"
              name="user_first_name"
              id="user_first_name"
              className="border-right"
              placeholder="* First name"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <input
              type="text"
              name="user_last_name"
              id="user_last_name"
              className="float-right"
              placeholder="* Last name"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <input
              type="password"
              name="password"
              id="password"
              className="border-right"
              placeholder="* Password"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <input
              type="password"
              name="password_confirmation"
              id="password_confirmation"
              placeholder="* Re-type password"
              className="float-right"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <input
              type="email"
              name="email"
              id="email"
              pattern="[^@]+@[^@]+.[a-zA-Z]{2,}"
              className="border-right"
              placeholder="* Email"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <input
              className="float-right"
              placeholder="  Phone (xxx) xxx-xxxx"
              type="text"
              name="phone[]"
              id="phone_"
              maxLength="14"
              autoComplete="off"
            />
          </div>
        </div>
      </section>
    );
  }
});
