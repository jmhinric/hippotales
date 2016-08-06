const UserNew = React.createClass({
  render() {
    const { user } = this.props;

    // email pattern="[^@]+@[^@]+.[a-zA-Z]{2,}"
    return (
      <section>
        <div className="Grid">
          <div className="Grid-cell u-size1of2">
            <ModelInput
              model={user}
              attribute="firstName"
              placeholder="* First name"
              classNames="border-right"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <ModelInput
              model={user}
              attribute="lastName"
              placeholder="* Last name"
              classNames="float-right"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <ModelInput
              type='password'
              model={user}
              attribute="password"
              placeholder="* Password"
              classNames="border-right"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <ModelInput
              type='password'
              model={user}
              attribute="passwordConfirmation"
              placeholder="* Re-type password"
              classNames="float-right"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <ModelInput
              type='email'
              model={user}
              attribute="email"
              placeholder="* Email"
              classNames="border-right"
            />
          </div>
          <div className="Grid-cell u-size1of2">
            <ModelInput
              model={user}
              attribute="phone"
              placeholder="  Phone (xxx) xxx-xxxx"
              classNames="float-right"
            />
          </div>
        </div>
      </section>
    );
  }
});
