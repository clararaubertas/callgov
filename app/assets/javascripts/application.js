// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require gmaps-auto-complete
//= require smart_listing
//= require bootstrap
//= require awesome-share-buttons
//= require_tree .



$(document).ready(function() {

    var input = document.getElementById('gmaps-input-address');
    var autocomplete = new google.maps.places.Autocomplete(input);

    $('#rep-chooser input[type=radio]').on('change', function() {
	$(this).closest("form").submit();
    });

    $('#rep-phone').on('click', function() {
	var values = $('#record_call').serialize();
	$.ajax({
	    type: "GET",
	    url: location.href,
	    data: values+'&'+$.param({ 'i_called': 'yes' })
	});
	window.location = "tel:" + $(this).text();
    });
    
});

