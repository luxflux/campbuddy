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
//= require bootstrap
//= require turbolinks
//= require_tree .


$(function() {
	// // // // // // // // // 
	//- filtering in workshops
	// // // // // // // // // 

	//variables
	var filter;
	var $filters = $('.activity-nav > span');
	var $activities =  $('.activities > div');

	$filters.on('click', function(e){
		//reset filters
		if($(this).hasClass('active')) {
			$activities.slideDown();
			$filters.removeClass('active not-filtered');
		} else {
			//styling
			$filters.addClass('not-filtered');
			$filters.removeClass('active');
			$(this).removeClass('not-filtered');
			$(this).addClass('active');

			//filtering
			filter = $(this).data('filter');
			$activities.each(function( index ) {
			  if( $(this).attr('class') != filter) {
			  	$(this).slideUp();
			  } else {
			  	$(this).slideDown();
			  }
			});
		}
	})

	// // // // // // // // // 
	//- hiding navigation bar
	// // // // // // // // // 

	//used in membership > new.html.erb
	if( hideNavBar === true ){
		$('nav').slideUp();
	} else {
		$('nav').slideDown();
	}


  /*this js is only used in the membership (show) view*/
	// // // // // // // // // 
	//- partipicate in workshop
	// // // // // // // // // 
	$('.partipicate').on('click', function(){
		$(this).toggleClass('yes');
		
		if($(this).hasClass('yes')){
			console.log('send data that member wants to partipicate');
			// $.post( "membership/new", function( data ) {
			//   send-partipicate-update
			// });
		} else {
			console.log('send data that member no longer want to partipicate');
			// $.post( "membership/new", function( data ) {
			//   send-partipicate-update
			// });
		}
	})
});





