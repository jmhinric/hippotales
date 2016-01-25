$(function(){
  HT.checked = function() {
    return $(".billing-address-checkbox :checkbox").prop("checked");
  };

  // mask the phone number input with format characters
  $("#phone_").mask("(999) 999-9999");

  $(".billing-address-checkbox :checkbox").click(function() {
    var checked = HT.checked();

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
  });

  $("#subscription_address_line1").change(function() {
    if (HT.checked()) {
      $("#user_address_line1").val($("#subscription_address_line1").val());
    }
  });

  $("#subscription_address_line2").change(function() {
    if (HT.checked()) {
      $("#user_address_line2").val($("#subscription_address_line2").val());
    }
  });

  $("#subscription_city").change(function() {
    if (HT.checked()) {
      $("#user_city").val($("#subscription_city").val());
    }
  });

  $("#subscription_state").change(function() {
    if (HT.checked()) {
      var state = $("#subscription_state").val();
      $("#user_state option[value='" + state + "'").attr("selected", true);
    }
  });

  $("#subscription_zip").change(function() {
    if (HT.checked()) {
      $("#user_zip").val($("#subscription_zip").val());
    }
  });
})();