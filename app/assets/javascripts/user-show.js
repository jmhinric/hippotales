var userShow = function() {
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
};

$(function() {
  $(document).on("page:change", userShow);
});
