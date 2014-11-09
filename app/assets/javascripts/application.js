// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require turbolinks
//= require pickadate/picker
//= require pickadate/picker.date
//= require pickadate/picker.time
//= require_tree .


$(function() {

	// // // // // // // // //
	//- hiding navigation bar
	// // // // // // // // //

	//used in membership > new.html.erb
	if( hideNavBar === true ){
		$('nav').slideUp();
	} else {
		$('nav').slideDown();
	}


	// // // // // // // // //
	//- partipicate in workshop
	// // // // // // // // //
	var userId = $('input#user_id').html();
	var eventId = $('input#event_id').html();
	var attendanceId = $('input#attendance_id').html();

	$('.partipicate').on('click', function(){
		$(this).toggleClass('yes');

		if($(this).hasClass('yes')){
			console.log('send data that member wants to partipicate');
			$.ajax({
		    url: 'http://localhost:3000/attendance/create',
		    type: 'POST',
		    data: {'user_id': userId, 'event_id': eventId},
		    success: function(result) {
		    	console.log("erst hier hacken setzen zumteilnehmen");
		    }
		  });
		} else {
			console.log('send data that member no longer want to partipicate');
			// $.ajax({
			//     url: '/script.cgi',
			//     type: 'DELETE',
			//     success: function(result) {
			//         // Do something with the result
			//     }
			// });
		}
	})
});
