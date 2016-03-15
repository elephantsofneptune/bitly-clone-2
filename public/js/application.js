$(document).ready(function() {

  $('#shortener-form').on('submit', function(event) {
    event.preventDefault();
    $.ajax({
      method: 'POST',
      url: '/urls',
      data: $(this).serialize(),
      dataType: 'html'
    }).done( function(response) {
      $('#links').show();
      $('#links').append(response);
    })
  })

  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
});
