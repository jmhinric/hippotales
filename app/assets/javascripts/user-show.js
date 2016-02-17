var userShow = function() {
  // Main menu toggle- Subscriptions and Account Info
  $("#subscriptions").click(function() {
    $("#user-show-subscriptions").removeClass("hidden");
    $("#user-show-account-info").addClass("hidden");

    $("#subscriptions").removeClass("inactive");
    $("#account-info").addClass("inactive");
  });

  $("#account-info").click(function() {
    $("#user-show-subscriptions").addClass("hidden");
    $("#user-show-account-info").removeClass("hidden");

    $("#subscriptions").addClass("inactive");
    $("#account-info").removeClass("inactive");
  });

  // Subscriptions sub-menu- Active and History
  $("#active-subscriptions").click(function() {
    $(".active-subscriptions").removeClass("hidden");
    $(".inactive-subscriptions").addClass("hidden");

    $("#active-subscriptions").removeClass("inactive");
    $("#inactive-subscriptions").addClass("inactive");
  });

  $("#inactive-subscriptions").click(function() {
    $(".active-subscriptions").addClass("hidden");
    $(".inactive-subscriptions").removeClass("hidden");

    $("#active-subscriptions").addClass("inactive");
    $("#inactive-subscriptions").removeClass("inactive");
  });
};

$(function() {
  $(document).on("page:change", userShow);
});
