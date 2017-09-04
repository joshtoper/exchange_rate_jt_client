$(function() {
  $('#exchange-rate-lookup').validate({
    rules: {
      date: "required",
      base: "required",
      counter: "required",
      amount: "required"
    }
  });

  $('a').on('click', function(event) {
    event.preventDefault();
    $.post('/update_exchange_rates').done(function() {
      alert('Exchange rates updated successfully.');
    }).fail(function() {
      alert('Something went wrong.');
    });
  });
});
