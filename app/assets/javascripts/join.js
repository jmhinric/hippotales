var join = function(){
  var giftChecked = function() {
    return $(".gift-message-checkbox :checkbox").prop("checked");
  };

  var giftMessage = function() {
    $(".gift-message").slideToggle(150);
  };

  var billingChecked = function() {
    return $(".billing-address-checkbox :checkbox").prop("checked");
  };

  var copyBilling = function() {
    var checked = billingChecked();

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
  };

  // mask the phone number input with format characters
  $("#phone_").mask("(999) 999-9999");

  // show/hide gift message
  $(".gift-message-checkbox :checkbox").click(giftMessage);
  $(".gift-message-checkbox label").click(function() {
    var checkbox = $(".gift-message-checkbox :checkbox");
    checkbox.prop("checked", !checkbox.prop("checked"));
    giftMessage();
  });

  // copy shipping address to billing address
  $(".billing-address-checkbox :checkbox").click(copyBilling);
  $(".billing-address-checkbox label").click(function() {
    var checkbox = $(".billing-address-checkbox :checkbox");
    checkbox.prop("checked", !checkbox.prop("checked"));
    copyBilling();
  });

  // update billing address fields on change
  $("#subscription_address_line1").change(function() {
    if (billingChecked()) {
      $("#user_address_line1").val($("#subscription_address_line1").val());
    }
  });

  $("#subscription_address_line2").change(function() {
    if (billingChecked()) {
      $("#user_address_line2").val($("#subscription_address_line2").val());
    }
  });

  $("#subscription_city").change(function() {
    if (billingChecked()) {
      $("#user_city").val($("#subscription_city").val());
    }
  });

  $("#subscription_state").change(function() {
    if (billingChecked()) {
      var state = $("#subscription_state").val();
      $("#user_state option[value='" + state + "'").attr("selected", true);
    }
  });

  $("#subscription_zip").change(function() {
    if (billingChecked()) {
      $("#user_zip").val($("#subscription_zip").val());
    }
  });

  // submit
  // $(".subscription-form").submit(function(e) {
  //   e.preventDefault();
  //   if (noErrors()) {
  //     $.post( "/users", $(this).serialize())
  //       .done(createSubscription)
  //       .fail(function() {
  //         console.log("There was a problem somewheres");
  //     });
  //   } else {
  //     console.log("Form problems");
  //   }
  // });

  // function userData() {
  //   return {
  //     first_name: $("#user_first_name").val(),
  //     last_name: $("#user_last_name").val(),
  //     password: $("#password").val(),
  //     password_confirmation: $("#password_confirmation").val(),
  //     email: $("#email").val(),
  //     phone: $("#phone").val(),
  //     address_line1: $("#user_address_line1").val(),
  //     address_line2: $("#user_address_line2").val(),
  //     city: $("#user_city").val(),
  //     state: $("#user_state").val(),
  //     zip: $("#user_zip").val()
  //   };
  // };

  function noErrors() {
    return passwordsMatch() && subscriptionSelected();
  };

  function passwordsMatch() {
    return $("#password").val() === $("#password_confirmation").val();
  };

  function subscriptionSelected() {
    return ["1", "3", "6"].includes($('input[type=radio]:checked').val());
  };

  function createSubscription(data) {
    $.get("users/" + data["user_id"]);
    console.log("Success!");
    console.log(data["success_message"]);
    // $.post("/join", function() {

    // })
    //   .done(function() {
    //     console.log("Success");
    //   })
    //   .fail(function() {
    //     console.log("There was a problem");
    // });
  };

  // Braintree

  function checkoutParams(result) {
    var nonce = "&nonce=" + result["nonce"];
    var paymentType = "&payment_type=" + result["type"]
    return $(".subscription-form").serialize() + nonce + paymentType;
  };

  var paymentNonceReceived = function(result) {
    console.log(result);
    if (noErrors()) {
      $.post( "/subscriptions", checkoutParams(result))
        .done(createSubscription)
        .fail(function(error) {
          console.log(`There was a problem somewhere: ${error.responseText}`);
      });
    } else {
      console.log("Form problems");
    }
  };

  var clientToken;
  $.get("/client_token")
    .done(function(result) {
      clientToken = result["client_token"]
      braintree.setup(clientToken, "dropin", {
        container: "payment-form",
        onPaymentMethodReceived: paymentNonceReceived
      });
    })
    .fail(function() {
      console.log("Failed to get Braintree client token.")
    });
};

$(function() {
  $(document).on("page:change", join);
});
