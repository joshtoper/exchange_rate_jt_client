$(function() {
  $('#exchange-rate-lookup').validate({
    rules: {
      date: "required",
      base: "required",
      counter: "required",
      amount: "required"
    }
  });
});
