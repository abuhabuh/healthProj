$.fn.extend({



  toggleVisible: function() {
    $(this).toggle(150);
  }

});

$(document).ready(function(){

  <!-- Setup functions -->

  $('.patient-main-hor').click(function() {
    $(this).next('.patient-detail-hor').toggle(150);
  });



});