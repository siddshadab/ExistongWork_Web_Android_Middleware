(function ( $ ) {
	$( 'body' ).on( 'click', function ( e ) {
		$( this ).closest( 'div.lang-dropdown' ).removeClass( 'langlist-showing' );
		$( this ).siblings( 'div.language-list' ).fadeOut(500);
	} );

	// btn-anim
	/*$( 'body' ).on( 'click', '.button', function ( e ) {
		$( this ).addClass( 'btn-anim' );
		setTimeout(function () {
			$( '.button' ).removeClass( 'btn-anim' );
		}, 1200);
	} );*/
	
	/* //-- language selection :: open list */
	$( 'body' ).on( 'click', 'div.language-bar div.lang-dropdown a.btn-selectlang', function ( e ) {
		e.stopPropagation();
		// if ( !$( this ).hasClass( 'selectlang-selected' ) ) {
		if ( !$( this ).closest( 'div.lang-dropdown' ).hasClass( 'langlist-showing' ) ) {
			// $( this ).addClass( 'selectlang-selected' );
			// $( this ).
			$( this ).closest( 'div.lang-dropdown' ).addClass( 'langlist-showing' );
			$( this ).siblings( 'div.language-list' ).fadeIn();
		} else {
			// $( this ).removeClass( 'selectlang-selected' );
			$( this ).closest( 'div.lang-dropdown' ).removeClass( 'langlist-showing' );
			$( this ).siblings( 'div.language-list' ).fadeOut(500);
		}
	} );
	/* //-- language selection :: select language */
	$( 'body' ).on( 'click', 'div.language-bar div.language-list ul.lst-languages>li>a', function ( e ) {
		e.stopPropagation();
		// var currentLanguage = $( this ).closest( 'ul.lst-languages' ).find( 'a.language-selected' ).text();
		if ( !$( this ).hasClass( 'language-selected' ) ) {
			$( this ).closest( 'ul.lst-languages' ).find( 'a' ).removeClass( 'language-selected' );
			$( this ).addClass( 'language-selected' );
			var currentLanguage = $( this ).text();
			$( this ).closest( 'div.lang-dropdown' ).removeClass( 'langlist-showing' );
			$( this ).closest( 'div.lang-dropdown' ).find( 'a.btn-selectlang em' ).html( currentLanguage );
			$( this ).closest( 'div.lang-dropdown' ).find( 'div.language-list' ).fadeOut(500);
		} else {
			$( this ).closest( 'div.lang-dropdown' ).removeClass( 'langlist-showing' );
			$( this ).closest( 'div.lang-dropdown' ).find( 'div.language-list' ).fadeOut(500);
		}
	} );

})( jQuery );

function loginPromoSlider () {
	var mySwiper = new Swiper ('div.promo-container div.swiper-container', {
	// Optional parameters
	// direction: 'vertical',
	// loop: true,
	// If we need pagination
	pagination: {
		el: '.swiper-pagination',
		// type: 'custom',
		clickable: true
	},
	// Navigation arrows
	navigation: {
		nextEl: '.swiper-button-next',
		prevEl: '.swiper-button-prev',
	},
	speed: 1800, 
	// autoplay: false{
	// 	delay: 5000
	// }, 
	autoplay: true, 
	parallax: true,
	// And if we need scrollbar
	// scrollbar: {
	// 	el: '.swiper-scrollbar',
	// },
  });
};

// function getLocation() {
// 	if (navigator.geolocation) {
// 		navigator.geolocation.getCurrentPosition(showPosition);
// 	} else { 
// 		x.innerHTML = "Geolocation is not supported by this browser.";
// 	}
// }
  
// function showPosition(position) {
// 	console.log(position);
// 	$("#latitude").val(position.coords.latitude);
// 	$("#longitude").val(position.coords.longitude);
// 	// x.innerHTML = "Latitude: " + position.coords.latitude + 
// 	// "<br>Longitude: " + position.coords.longitude;
// }

function getDate(selectedValue){
	$(selectedValue).datepicker();
	//console.log("date working");
	// var hours = new Date().getHours();
	// //console.log(hours);
	// var mins = new Date().getMinutes();
	// //console.log(mins);
	// if(mins<10){
	// 	mins = 0+''+mins;
	// }
	// //console.log(mins);
	// var secs = new Date().getSeconds();
	// //console.log(secs);
	// if(secs<10){
	// 	secs = 0+''+secs;
	// }
	// //console.log(secs);
	// $(selectedValue).datepicker(
	// 	//{dateFormat: 'yy-mm-dd ' +hours+ ':'+mins+':'+secs }
	// 	{dateFormat: 'dd-mm-yy ' +hours+ ':'+mins+':'+secs }
	// );
}