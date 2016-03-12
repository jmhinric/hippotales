HT.Join = function() {
  this.hasSubmitted = false;
  this.termsConditionsOpen = false;

  this.INVALID_BIRTHDAY_MESSAGE = "Invalid Birthday";
  this.TERMS_CONDITIONS_MESSAGE = "You must agree to the Terms and Conditions";
  this.FAILED_TO_SUBMIT_MESSAGE = "Something is wrong with the form. Please try again."
  this.SERVER_JOIN_ERROR_MESSAGE = "Something went wrong. Please try again."
};

HT.Join.prototype.init = function() {
  var self = this;

  // fix color of placeholder text for dropdowns
  $("select").val("").css("color", "rgb(173, 173, 173)");
  $("select").change(function(e) {
    var color = $(e.target).val() === "" ? "rgb(173, 173, 173)" : "black";
    $(e.target).css("color", color);
  });
  // fix color of placeholder text for date selector
  var dateInput = $("input[type=date]");
  dateInput.css("color", "rgb(173, 173, 173)")
  dateInput.on("change keyup, keydown", function() {
    var color = dateInput.val() === '' ? "rgb(173, 173, 173)" : "black";
    dateInput.css("color", color);
  });

  // mask the phone number input with format characters
  $("#phone_").mask("(999) 999-9999");

  // set up behavior for the 'is gift' checkbox
  $(".gift-message-checkbox :checkbox").click(this.giftMessage.bind(this));
  $(".gift-message-checkbox label").click(function() {
    self.setCheckbox($(".gift-message-checkbox :checkbox"));
    self.giftMessage();
  });

  // set up behavior for the 'same address' checkbox
  $(".billing-address-checkbox :checkbox").change(function(e) {
    if ($(".billing-address-checkbox :checked").prop("checked")) {
      $(".billing-address-checkbox :checked").val("true");
    }
    self.copyBilling();
  });
  $(".billing-address-checkbox label").click(function() {
    self.setCheckbox($(".billing-address-checkbox :checkbox"));
    self.copyBilling();
  });

  // highlight the selected subscription
  $(".subscription-options input:radio").click(function(e) {
    $(e.target.parentElement).addClass("selected");
    $(e.target.parentElement).siblings().removeClass("selected");
  });

  // update billing address fields on change
  this.addressListenersSetup(self);

  // set up terms and conditions modal behavior
  $(".terms-link").click(this.toggleTermsConditions);
  $(".close-terms").click(this.toggleTermsConditions);

  // set up confirm subscription page behavior
  $(".close-confirm").click(this.toggleConfirmModal);
  $(".confirm-submit").click(this.sendConfirmedSubscription.bind(self));

  // initial Braintree setup
  $.get("/client_token")
    .done(function(result) {
      braintree.setup(result["client_token"], "dropin", {
        container: "payment-form",
        onPaymentMethodReceived: self.paymentNonceReceived.bind(self)
      });
    })
    .fail(function() {
      console.log("Failed to get Braintree client token.")
    });
};

// shows/hides the gift message
HT.Join.prototype.giftMessage = function() {
  $(".gift-message").slideToggle(150);
};

HT.Join.prototype.billingChecked = function() {
  return $(".billing-address-checkbox :checkbox").prop("checked");
};

// toggles the checked prop and value of the given checkbox element
HT.Join.prototype.setCheckbox = function(checkbox) {
  var checkedState = checkbox.prop("checked");
  checkbox.val(!checkedState)
          .prop("checked", !checkedState);
};

// copies shipping address to billing address
HT.Join.prototype.copyBilling = function() {
  var checked = this.billingChecked();

  var address_line1 = checked ? $("#subscription_address_line1").val() : "";
  var address_line2 = checked ? $("#subscription_address_line2").val() : "";
  var city = checked ? $("#subscription_city").val() : "";
  var state = checked ? $("#subscription_state").val() : "";
  var zip = checked ? $("#subscription_zip").val() : "";

  $("#user_address_line1").val(address_line1);
  $("#user_address_line2").val(address_line2);
  $("#user_city").val(city);
  $("#user_state option[value='" + state + "'").attr("selected", true);
  $("#user_zip").val(zip);

  this.updateStatePlaceholder();

  if (this.hasSubmitted) { this.noRequiredErrors(); }
};

HT.Join.prototype.addressListenersSetup = function(self) {
  $("#subscription_address_line1").change(function() {
    if (self.billingChecked()) {
      $("#user_address_line1").val($("#subscription_address_line1").val());
    }
    if (self.hasSubmitted) { self.validateRequired("#user_address_line1") }
  });

  $("#subscription_address_line2").change(function() {
    if (self.billingChecked()) {
      $("#user_address_line2").val($("#subscription_address_line2").val());
    }
  });

  $("#subscription_city").change(function() {
    if (self.billingChecked()) {
      $("#user_city").val($("#subscription_city").val());
    }
    if (self.hasSubmitted) { self.validateRequired("#user_city") }
  });

  $("#subscription_state").change(function() {
    if (self.billingChecked()) {
      var state = $("#subscription_state").val();
      $("#user_state option[value='" + state + "'").attr("selected", true);
      this.updateStatePlaceholder();
    }
    if (self.hasSubmitted) { self.validateRequired("#user_state") }
  });

  $("#subscription_zip").change(function() {
    if (self.billingChecked()) {
      $("#user_zip").val($("#subscription_zip").val());
    }
    if (self.hasSubmitted) { self.validateRequired("#user_zip") }
  });
};

HT.Join.prototype.updateStatePlaceholder = function() {
  var stateColor = $("#user_state").val() === "" ? "rgb(173, 173, 173)" : "black";
  $("#user_state").css("color", stateColor);
};

// Error handling
HT.Join.prototype.errorListenersSetup = function() {
  var self = this;
  this.requiredFields().forEach(function(field) {
    $(field).on("change keyup keydown", function() {
      self.validateRequired(field);
    });
  });

  $('input[type=radio]').click(this.subscriptionSelected.bind(this));

  $('input[type=date]').on("change keyup blur", this.validChildBirthday.bind(this));

  $('#terms_conditions').click(this.termsAndConditions.bind(this));
};

HT.Join.prototype.renderError = function(message) {
  $(".flash").children().remove();
  $(".flash").append($("<div class='flash-message error'>").text(message));
};

HT.Join.prototype.noErrors = function() {
  $(".flash-message").remove();

  return this.termsAndConditions() &&
    this.noRequiredErrors() &&
    this.passwordsMatch() &&
    this.validChildBirthday();
};

HT.Join.prototype.noRequiredErrors = function() {
  var self = this;
  var errors = false;
  this.requiredFields().forEach(function(field) {
    if (!self.validateRequired(field)) { errors = true; }
  });
  if (!this.subscriptionSelected()) { errors = true }

  if (errors) { this.renderError("Please fill in all required fields") }

  return !errors;
};

HT.Join.prototype.subscriptionSelected = function() {
  var valid = ["1", "3", "6"].includes($('input[type=radio]:checked').val());
  if (valid) {
    $(".subscription-options").removeClass("required-error")
  }
  else {
    $(".subscription-options").addClass("required-error");
  }

  return valid;
};

// param: [String]
HT.Join.prototype.validateRequired = function(cssSelector) {
  var el = $(cssSelector);
  var notEmpty = el.val() !== "";
  notEmpty ? el.removeClass("required-error") : el.addClass("required-error");

  return notEmpty;
};

HT.Join.prototype.requiredFields = function() {
  return [
    "#child_first_name",
    "#child_last_name",
    "#child_birthday",
    "#child_gender",

    "#subscription_address_line1",
    "#subscription_city",
    "#subscription_state",
    "#subscription_zip",

    "#user_first_name",
    "#user_last_name",
    "#password",
    "#password_confirmation",
    "#email",
    "#phone",

    "#user_address_line1",
    "#user_city",
    "#user_state",
    "#user_zip"
  ]
};

HT.Join.prototype.passwordsMatch = function() {
  $(".flash-message").text(this.INVALID_BIRTHDAY_MESSAGE).remove();

  var match = $("#password").val() === $("#password_confirmation").val();
  if (match) {
    $("#password").removeClass("required-error");
    $("#password_confirmation").removeClass("required-error");
  }
  else {
    $("#password").addClass("required-error");
    $("#password_confirmation").addClass("required-error");
    this.renderError("Passwords don't match");
  }

  return match;
};

HT.Join.prototype.validChildBirthday = function() {
  $(".flash-message").text(this.INVALID_BIRTHDAY_MESSAGE).remove();

  var valid = this.validBirthDay() && this.validBirthMonth() && this.validBirthYear();

  if (valid) {
    $("#child_birthday").removeClass("required-error");
  }
  else {
    $("#child_birthday").addClass("required-error");
    this.renderError(this.INVALID_BIRTHDAY_MESSAGE);

  }
  return valid;
};

HT.Join.prototype.validBirthDay = function() {
  var birthDay = parseInt(moment($("#child_birthday").val()).format("DD"), 10);
  return 0 < birthDay && birthDay < 31;
};

HT.Join.prototype.validBirthMonth = function() {
  var birthMonth = parseInt(moment($("#child_birthday").val()).format("MM"), 10);
  return 0 < birthMonth && birthMonth < 13;
};

HT.Join.prototype.validBirthYear = function() {
  var birthYear = parseInt(moment($("#child_birthday").val()).format("YYYY"), 10);
  return this.validBirthYears().includes(birthYear);
};

HT.Join.prototype.validBirthYears = function() {
  var currentYear = parseInt(new moment().format("YYYY"), 10);
  var years = [];
  for (var i = 0; i < 10; i++) {
    years.push(currentYear - i);
  }
  return years;
};

HT.Join.prototype.termsAndConditions = function() {
  $(".flash-message").text(this.TERMS_CONDITIONS_MESSAGE).remove();

  var valid = $('#terms_conditions').prop("checked");

  if (valid) {
    $(".terms-conditions-checkbox").removeClass("required-error");
  }
  else {
    $(".terms-conditions-checkbox").addClass("required-error");
    this.renderError(this.TERMS_CONDITIONS_MESSAGE);

  }
  return valid;
};

HT.Join.prototype.toggleTermsConditions = function() {
  $('.terms-conditions-wrapper').toggleClass("hidden");
};

HT.Join.prototype.toggleConfirmModal = function() {
  $(".confirm-subscription-wrapper").toggleClass("hidden");
  $(".subscription-container").toggleClass("hidden");
};

HT.Join.prototype.renderConfirmModalDetails = function() {
  $(".confirm-subscription-type").text(this.subscriptionTypeData());

  $(".confirm-child-name").text($("#child_first_name").val() + " " + $("#child_last_name").val());
  $(".confirm-child-birth").text(moment($("#child_birthday").val()).format("LL"));

  $(".confirm-child-gender").text($("#child_gender").val());

  $(".confirm-shipping-address-line1").text($("#subscription_address_line1").val());

  $(".confirm-shipping-address-line2").text($("#subscription_address_line2").val());

  $(".confirm-shipping-address-city-state-zip").text(
    $("#subscription_city").val() + ", " +
      $("#subscription_state").val() + "  " + $("#subscription_zip").val()
  );
  $(".confirm-is-gift").text(this.isGiftText());

  $(".confirm-gift-message").text(this.giftMessageText());

  $(".confirm-account-name").text($("#user_first_name").val() + " " + $("#user_last_name").val());

  $(".confirm-account-email").text($("#email").val());

  $(".confirm-account-phone").text($("#phone_").val());

  $(".confirm-user-address-line1").text($("#user_address_line1").val());

  $(".confirm-user-address-line2").text($("#user_address_line2").val());

  $(".confirm-user-address-city-state-zip").text(
    $("#user_city").val() + ", " + $("#user_state").val() + "  " + $("#user_zip").val()
  );
};

HT.Join.prototype.subscriptionTypeData = function() {
  var months = $("input[type=radio]:checked").val();
  var cost;
  if (months === "1") {
    cost = "$29.99";
  }
  else if (months === "3") {
    cost = "$27.99";
  }
  else if (months === "6") {
    cost = "$25.99";
  }
  return months + " month subscription, " + cost + "/month"
};

HT.Join.prototype.isGiftText = function() {
  return $(".gift-message-checkbox :checked").prop("checked") ? "Yes" : "No";
};

HT.Join.prototype.giftMessageText = function() {
  return $(".gift-message-checkbox :checked").prop("checked") ? $("#gift_message").val() : "";
};

// Braintree
HT.Join.prototype.paymentNonceReceived = function(result) {
  this.hasSubmitted = true;
  this.nonce = result;

  if (this.noErrors()) {
    this.renderConfirmModalDetails();
    $(".confirm-subscription-wrapper").toggleClass("hidden");
    $(".subscription-container").toggleClass("hidden");
  }
  this.errorListenersSetup();
};

HT.Join.prototype.sendConfirmedSubscription = function() {
  this.toggleConfirmModal();
  var self = this;
  if (this.noErrors() && this.nonce) {
    $.post( "/subscriptions", this.checkoutParams())
      .fail(function(error) {
        console.log("There was a problem somewhere: " + error.responseText);
        self.renderError(self.SERVER_JOIN_ERROR_MESSAGE);
      });
  }
  else {
    this.renderError(this.FAILED_TO_SUBMIT_MESSAGE);
  }
};

HT.Join.prototype.checkoutParams = function() {
  var nonce = "&nonce=" + this.nonce["nonce"];
  var paymentType = "&payment_type=" + this.nonce["type"]
  return $(".subscription-form").serialize() + nonce + paymentType;
};


$(document).on("page:change", function() {
  new HT.Join().init();

  // clear Braintree iframes to prevent duplicates
  $("#payment-form iframe").remove();
});
