var userShow = function() {
  // Main menu
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

  // Subscriptions sub-menu
  $("#active-subscriptions").click(function() {
    $(".active-subscriptions").removeClass("hidden");
    $(".inactive-subscriptions").addClass("hidden");
    $(".gift-subscriptions").addClass("hidden");

    $("#active-subscriptions").removeClass("inactive");
    $("#inactive-subscriptions").addClass("inactive");
    $("#gift-subscriptions").addClass("inactive");
  });

  $("#inactive-subscriptions").click(function() {
    $(".active-subscriptions").addClass("hidden");
    $(".inactive-subscriptions").removeClass("hidden");
    $(".gift-subscriptions").addClass("hidden");

    $("#active-subscriptions").addClass("inactive");
    $("#inactive-subscriptions").removeClass("inactive");
    $("#gift-subscriptions").addClass("inactive");
  });

  $("#gift-subscriptions").click(function() {
    $(".active-subscriptions").addClass("hidden");
    $(".inactive-subscriptions").addClass("hidden");
    $(".gift-subscriptions").removeClass("hidden");

    $("#active-subscriptions").addClass("inactive");
    $("#inactive-subscriptions").addClass("inactive");
    $("#gift-subscriptions").removeClass("inactive");
  });
};

$(function() {
  $(document).on("page:change", userShow);
});
