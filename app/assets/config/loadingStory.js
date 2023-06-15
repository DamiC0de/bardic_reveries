$(document).ready(function() {
    $('form').on('submit', function() {
      console.log("Form submitted"); // Ajouter cette ligne
      $('#loading-screen').show();
      $('body').css('pointer-events', 'none');
    });
  });
