$(document).ready(function() {
    $('form').on('submit', function() {
      console.log("Form submitted"); 
      $('#loading-screen').show();
      $('body').css('pointer-events', 'none');
    });
  });
