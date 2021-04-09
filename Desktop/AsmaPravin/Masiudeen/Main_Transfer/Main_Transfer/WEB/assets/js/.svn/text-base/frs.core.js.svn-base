// main application script file - frs.core.js
"use strict";
(function ( $ ) {
	/* -- form control click */
	$( 'body' ).on( 'click', 'div.form-controller', function ( e ) {
		$( this ).children( 'input' ).focus();
		$( this ).children( 'select' ).focus();
		$( this ).children( 'textarea' ).focus();
	} );
	/* -- form control for input text */
	$( 'body' ).on( 'focus', 'div.form-controller>input', function ( e ) {
		if ( !$( this ).parent( 'div.form-controller' ).hasClass( 'disabled' ) ) {
			if ( !$( this ).parent( 'div.form-controller' ).hasClass( 'control-active' ) ) {
				$( this ).closest( 'div.form-controller' ).addClass( 'control-active' );
			}
		} else {
			$( this ).attr( 'disabled', 'disabled' );
		}
	} );
	$( 'body' ).on( 'blur', 'div.form-controller>input', function ( e ) {
		$( this ).parent( 'div.form-controller' ).removeClass( 'control-active' );
	} );

	/* -- form control for select */
	$( 'body' ).on( 'focus', 'div.form-controller>div>select', function ( e ) {
		if ( !$( this ).closest( 'div.form-controller' ).hasClass( 'disabled' ) ) {
			if ( !$( this ).closest( 'div.form-controller' ).hasClass( 'control-active' ) ) {
				//$( 'div.form-controller' ).removeClass( 'control-active' );
				$( this ).closest( 'div.form-controller' ).addClass( 'control-active' );
			}
		} else {
			$( this ).attr( 'disabled', 'disabled' );
		}
	} );
	$( 'body' ).on( 'blur', 'div.form-controller>div>select', function ( e ) {
		//if ( !$( this ).hasClass( 'control-active' ) ) {
			//$( 'div.form-controller' ).removeClass( 'control-active' );
			// console.log( 'bluring now...' );
			$( this ).closest( 'div.form-controller' ).removeClass( 'control-active' );
		//}
	} );

	/* -- form control for textarea text */
	$( 'body' ).on( 'focus', 'div.form-controller>textarea', function ( e ) {
		if ( !$( this ).parent( 'div.form-controller' ).hasClass( 'disabled' ) ) {
			if ( !$( this ).parent( 'div.form-controller' ).hasClass( 'control-active' ) ) {
				//$( 'div.form-controller' ).removeClass( 'control-active' );
				$( this ).closest( 'div.form-controller' ).addClass( 'control-active' );
			}
		} else {
			$( this ).attr( 'disabled', 'disabled' );
		}
	} );
	$( 'body' ).on( 'blur', 'div.form-controller>textarea', function ( e ) {
		//if ( !$( this ).hasClass( 'control-active' ) ) {
			//$( 'div.form-controller' ).removeClass( 'control-active' );
			// console.log( 'bluring now...' );
			$( this ).parent( 'div.form-controller' ).removeClass( 'control-active' );
		//}
	} );

	/* -- global header items - user profile popup show/hide */
	$( 'body' ).on( 'click', 'div.header-items ul.lst-header-items li a.item-user', function ( e ) {
		if ( !$( this ).hasClass( 'item-user-active' ) ) {
			$( this ).addClass( 'item-user-active' );
			$( this ).closest( 'li' ).find( 'div.sp-userprofile' ).addClass( 'sp-up-showing' );
		} else {
			$( this ).removeClass( 'item-user-active' );
			$( this ).closest( 'li' ).find( 'div.sp-userprofile' ).removeClass( 'sp-up-showing' );
		}
	} );

	/* -- global BIG header items - navigation button */
	$( 'body' ).on( 'click', 'div.header-items ul.lst-header-items li a.item-nav', function ( e ) {
		if ( !$( this ).hasClass( 'menu-active' ) ) {
			$( this ).addClass( 'menu-active' );
			$( 'nav.global-nav.sticky-nav' ).addClass( 'nav-showing' );
			$( 'body' ).addClass( 'bglnav-open' );
			// $( 'nav.global-nav.sticky-nav.shift-nav' ).addClass( 'shift-over' );
		} else {
			$( this ).removeClass( 'menu-active' );
			$( 'nav.global-nav.sticky-nav' ).removeClass( 'nav-showing' );
			$( 'body' ).removeClass( 'bglnav-open' );
			// $( 'nav.global-nav.sticky-nav.shift-nav' ).removeClass( 'shift-over' );
		}
	} );

	/* -- component - tabs */
	$( 'body' ).on( 'click', 'nav.tab-controller div.tabs>ul.lst-tabs>li>a', function ( e ) {
		if ( !$( this ).hasClass( 'tab-selected' ) ) {
			var selectedIndex = $( this ).parent( 'li' ).index();
			$( this ).closest( 'nav.tab-controller' ).find( 'div.tabs-container' ).children( 'div.tab-content' ).removeClass( 'tc-showing' );
			$( this ).closest( 'ul.lst-tabs' ).find( 'a' ).removeClass( 'tab-selected' );
			$( this ).addClass( 'tab-selected' );
			$( this ).closest( 'nav.tab-controller' ).find( 'div.tabs-container' ).children( 'div.tab-content' ).eq( selectedIndex ).addClass( 'tc-showing' );
		}
	} );

	/* -- toast message close on click */
	$( 'body' ).on( 'click', 'div.toast-messages div.msg-toast', function() {
		setTimeout(function () {
			$( 'div.toast-messages' ).find( '.msg-toast' ).removeClass( 'msg-showing' );
		}, 300);
		setTimeout( function () {
			$( 'div.toast-messages' ).html( '' );
		}, 500 );
	} );

	/* -- Important Note */
	$( 'body' ).off( 'click', 'div.important-note div.impnote-heading>a' );
	$( 'body' ).on( 'click', 'div.important-note div.impnote-heading>a', function() {
		if ( !$( this ).hasClass( 'note-active' ) ) {
			// $( 'html, body' ).animate( {scrollTop : $( this ).offset().top - 100 }, 700 );
			$( this ).addClass( 'note-active' );
			$( this ).closest( 'div.important-note' ).find( 'div.impnote-content' ).slideDown();
		} else {
			$( this ).removeClass( 'note-active' );
			$( this ).closest( 'div.important-note' ).find( 'div.impnote-content' ).slideUp();
		}
	});

	/* //set modal height */
	$('.modal').on('shown.bs.modal', function (e) {
		setModalHeight( $( this ) );
	});
	$( window ).on( 'resize', function ( e ) {
		setModalHeight();
	});

	/* //page wrapper spacing for fixed header and nav */
	$( window ).on( 'resize', function ( e ) {
		//pageWrapperSpacing();
	});

	/* -- header compress when scroll */
	$( window ).on( 'scroll', function ( e ) {
		//tinyHeader();
	});

	/* //export dataTable files format for mobile dropdown */
	$( 'body' ).on( 'click', 'div.dt-exports>em', function() {
		if ( !$( this ).parent( 'div.dt-exports' ).hasClass( 'expdrop-showing' ) ) {
			$( this ).parent( 'div.dt-exports' ).addClass( 'expdrop-showing' );
		} else {
			$( this ).parent( 'div.dt-exports' ).removeClass( 'expdrop-showing' );
		}
	} );

	var sub_menu_timer;
	//var data = '';
	$( 'body' ).on( 'click', 'nav.global-nav div.navigation-items>ul.lst-navigation>li>a', function ( e ) {
		var curr = $(this);
		var no_child_nav = false;
		$('nav.global-nav div.navigation-items>ul.lst-navigation>li>a').removeClass('active');
		$(this).addClass('active');
		//console.log('mouse');
		if(!$(this).siblings().hasClass('subnavigation-items-new')){
			$('nav.global-nav div.navigation-items>ul.lst-navigation>li>a').removeClass('last-active');
			curr.addClass('last-active');
			//console.log('no-child-nav');
		}

		sub_menu_timer = setTimeout(function() {
			//console.log('settime');
			//$('.submenu').show();
			$('div.subnavigation-items-new').fadeOut(500);
			curr.parent().find('div.subnavigation-items-new').first().fadeIn(300);
			//data = $(this).parent().find('div.subnavigation-items-new').first();
        },100);
		// $('div.subnavigation-items-new').fadeOut(1000);
		// $(this).parent().find('div.subnavigation-items-new').first().fadeIn(1000);
		// data = $(this).parent().find('div.subnavigation-items-new').first();
	} );
	$( 'body' ).on( 'mouseleave', '#main-nav', function ( e ) {
		//clearTimeout(sub_menu_timer);
		$('div.subnavigation-items-new').fadeOut(300);
		$('nav.global-nav div.navigation-items>ul.lst-navigation>li>a').removeClass('active');
		//console.log(data);
		//console.log('yup');
		//data.fadeOut(1000);
	} );

	$( 'body' ).on( 'click', 'nav.global-nav div.navigation-items>ul.lst-navigation>li>.subnavigation-items-new', function ( e ) {
		//var curr = $(this);
		$('nav.global-nav div.navigation-items>ul.lst-navigation>li>a').removeClass('last-active');
		$(this).parent().find('a').first().addClass('last-active');
		//console.log('mouse');
	} );

	$( 'body' ).on( 'click', 'nav.global-nav div.navigation-items>ul.lst-navigation>li>.subnavigation-items-new>.lst-subnavigation>li>a.has-subdata', function ( e ) {
		
		var current = $(this);
		//console.log("active");
		//current.parent().find('.subnavigation-items-sub-new').slideToggle();

		if(!current.hasClass('active')){
			current.addClass('active');
			$('.subnavigation-items-sub-new').slideUp();
			current.parent().find('.subnavigation-items-sub-new').slideDown();
		}else{
			current.parent().find('.subnavigation-items-sub-new').slideUp();
			current.removeClass('active');
		}
		
	} );

	// $( 'body' ).on( 'click', 'nav.global-nav div.navigation-items>ul.lst-navigation>li>.subnavigation-items-new>.lst-subnavigation>li>a', function ( e ) {
	// 	e.stopPropagation();
	// 	return false;
	// 	//var curr = $(this);
	// 	console.log($(this).attr('href'));
	// 	var curr_href = $(this).attr('href');
	// 	if(curr_href == "/"){
	// 		e.preventDefault();
	// 	}
	// 	//$('nav.global-nav div.navigation-items>ul.lst-navigation>li>a').removeClass('last-active');
	// 	//$(this).parent().find('a').first().addClass('last-active');
	// 	//console.log('mouse');
	// } );



	// $('nav.global-nav div.navigation-items>ul.lst-navigation>li>a, .subnavigation-items-new').on({
	// 	mouseenter: function () {
	// 		$(this).parent().find('div.subnavigation-items-new').first().fadeIn(1000);
	// 	},
	// 	mouseleave: function () {
	// 		$(this).parent().find('div.subnavigation-items-new').first().fadeOut(1000);
	// 	}
	// });


	/* //global navigation - showing submenu navigation */
	// $( 'body' ).on( 'click', 'nav.global-nav div.navigation-items>ul.lst-navigation>li>a', function ( e ) {
	// 	if ( !$( this ).hasClass( 'glnavi-active' ) ) {
	// 		$( this ).closest( 'ul.lst-navigation' ).children( 'li' ).find( 'a' ).removeClass( 'glnavi-active' );
	// 		$( this ).closest( 'ul.lst-navigation' ).children( 'li' ).find( 'div.subnavigation-items' ).removeClass( 'subnav-showing' ).slideUp();
	// 		$( this ).addClass( 'glnavi-active' );
	// 		$( this ).siblings( 'div.subnavigation-items' ).addClass( 'subnav-showing' ).slideDown();
	// 	} else {
	// 		$( this ).removeClass( 'glnavi-active' );
	// 		$( this ).siblings( 'div.subnavigation-items' ).removeClass( 'subnav-showing' ).slideUp();
	// 	}
	// } );

	// $( 'body' ).on( 'mouseenter', 'nav.global-nav div.navigation-items>ul.lst-navigation>li>a', function ( e ) {
	// 	e.preventDefault();
	// 	console.log('mouseenter');
	// 	//$("#floating-nav").fadeIn('slow');
	// 	var now = new Date();
	// 	//var sec = 0;
	// 	//var seconds = (now.getTime() - startDate.getTime()) / 1000;
	// 	var curr_sec = now.getSeconds();
	// 	//console.log(now.getSeconds());
	// 	//$('#runtimes').append('<p>' + seconds + '</p>');
	// 	setTimeout(function(){
	// 		var sec = new Date();
	// 		//console.log(sec.getSeconds());
	// 		var after_timeout_sec = sec.getSeconds();
	// 		console.log(curr_sec);
	// 		console.log(after_timeout_sec);
	// 		if(curr_sec > after_timeout_sec){
	// 			$("#floating-nav").fadeIn('slow');
	// 		}
	// 	},1000);
	// });
	// $( 'body' ).on( 'mouseleave', 'nav.global-nav div.navigation-items>ul.lst-navigation>li>a', function ( e ) {
	// 	e.preventDefault();
	// 	console.log('mouseleave');
	// 	$("#floating-nav").fadeOut('slow');
	// });

	// $( 'body' ).on( 'click', 'nav.global-nav div.navigation-items>ul.lst-navigation>li>div.subnavigation-items>ul.lst-subnavigation>li>a', function ( e ) {
	// 	if ( !$( this ).hasClass( 'glsubnavi-active' ) ) {
	// 		$( this ).closest( 'ul.lst-subnavigation' ).children( 'li' ).find( 'a' ).removeClass( 'glsubnavi-active' );
	// 		$( this ).closest( 'ul.lst-subnavigation' ).children( 'li' ).find( 'div.subnavigation-items' ).slideUp();
	// 		$( this ).closest( 'ul.lst-subnavigation' ).children( 'li' ).find( 'div.subnavigation-items' ).removeClass( 'super-subnav-showing' );
	// 		$( this ).addClass( 'glsubnavi-active' );
	// 		$( this ).siblings( 'div.subnavigation-items' ).addClass( 'super-subnav-showing' );
	// 		$( this ).siblings( 'div.subnavigation-items' ).slideDown();
	// 	} else {
	// 		$( this ).removeClass( 'glsubnavi-active' );
	// 		$( this ).siblings( 'div.subnavigation-items' ).slideUp();
	// 		//$( this ).siblings( 'div.subnavigation-items' ).removeClass( 'super-subnav-showing' );
	// 	}
	// } );

	/* component - file upload */
	$( 'body' ).on( 'change', 'div.file-input input[type="file"]', function () {
		if ($( this ).val() !== null) {
			var fullPath = $( this ).val();
			if (fullPath) {
				var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
				var ufilename = fullPath.substring(startIndex);
				if (ufilename.indexOf('\\') === 0 || ufilename.indexOf('/') === 0) {
					ufilename = ufilename.substring(1);
				}
				$( this ).siblings( 'label' ).find( 'h4' ).html( ufilename );
				$( this ).siblings( 'label' ).find( 'p' ).html( 'click upload to view records' );
				$( this ).parent( 'div.file-input' ).addClass( 'fileuploading' );
			}
		}
	} );

	/* -- global header items - help modal show/hide */
	$( 'body' ).on( 'click', 'nav.global-nav div.navigation-items>ul.lst-navigation>li.mb-help>a', function ( e ) {
		$( 'div.header-items ul.lst-header-items li a.item-help' ).trigger( 'click' );
	} );
	//var calcPadding = bootgetScrollbarWidth();
	$( 'body' ).on( 'click', 'div.header-items ul.lst-header-items li a.item-help', function ( e ) {
		if ( !$( this ).hasClass( 'item-help-active' ) ) {
			$( this ).addClass( 'item-help-active' );
			// $( 'div.help-overlay' ).fadeIn();
			$( 'div.help-box' ).show( 0 ).addClass( 'helpbox-showing' );
			// $( 'div.pc-modal#modal-' + prindex ).show(0).addClass( 'pcmodal-showing' );
			// $( 'div.promo-wrapper' ).addClass( 'promo-overlay' );
			var calcPadding = bootgetScrollbarWidth();
			$( 'body' ).addClass( 'bglhelp-open' );
			// $( 'body' ).addClass( 'bglhelp-open' ).css( 'padding-right', calcPadding );
			// $( 'header.global-header.sticky-header, nav.global-nav.sticky-nav, footer.global-footer.sticky-footer' ).css( 'right', calcPadding );
			// $( 'body' ).append('<div />').addClass('modal-scrollbar-measure');
			// $( '<div></div>' ).addClass( 'modal-scrollbar-measure' ).appendTo( 'body' );
			// console.log($.fn.tooltip.Constructor.VERSION);
			// console.log($.fn.modal._getScrollbarWidth());
		} else {
			$( this ).removeClass( 'item-help-active' );
			// $( 'div.help-overlay' ).fadeOut();
			$( 'div.help-box' ).removeClass( 'helpbox-showing' );
			// $( 'header.global-header.sticky-header, nav.global-nav.sticky-nav, footer.global-footer.sticky-footer' ).css( 'right', 0 );
			$( 'body' ).removeClass( 'bglhelp-open' );
		}
	} );
	// help-close
	$( 'body' ).on( 'click', 'div.help-box a.help-close, div.help-box div.help-overlay', function ( e ) {
		$( 'div.header-items ul.lst-header-items li a.item-help' ).removeClass( 'item-help-active' );
		$( 'nav.global-nav div.navigation-items>ul.lst-navigation>li.mb-help>a' ).removeClass( 'item-help-active glnavi-active' );
		$( 'div.help-box' ).removeClass( 'helpbox-showing' );
		// $( 'body' ).removeClass( 'bglhelp-open' ).css( 'padding-right', 0 );
		$( 'body' ).removeClass( 'bglhelp-open' );
		// $( 'header.global-header.sticky-header, nav.global-nav.sticky-nav, footer.global-footer.sticky-footer' ).css( 'right', 0 );
		setTimeout(function () {
			$( 'div.help-box' ).fadeOut(100);
		}, 600);
	} );

	// help search text box click focus 
	// hsearch-control
	$( 'body' ).on( 'click', 'div.help-box div.hsearch-form div.hsearch-control', function ( e ) {
		$( this ).find( 'input' ).focus();
	} );
	$( 'body' ).on( 'focus', 'div.help-box div.hsearch-form div.hsearch-control input.txt-glhelp-search', function ( e ) {
		$( this ).parents( 'div.hsearch-control' ).addClass( 'hsc-active' );
	} );
	$( 'body' ).on( 'blur', 'div.help-box div.hsearch-form div.hsearch-control input.txt-glhelp-search', function ( e ) {
		$( this ).parents( 'div.hsearch-control' ).removeClass( 'hsc-active' );
	} );

	/* -- global header items - template modal show/hide */
	$( 'body' ).on( 'click', 'nav.global-nav div.navigation-items>ul.lst-navigation>li.mb-template>a', function ( e ) {
		$( 'div.header-items ul.lst-header-items li a.item-template' ).trigger( 'click' );
	} );
	//var calpad = bootgetScrollbarWidth();
	$( 'body' ).on( 'click', 'div.header-items ul.lst-header-items li a.item-template', function ( e ) {
		if ( !$( this ).hasClass( 'item-template-active' ) ) {
			$( this ).addClass( 'item-template-active' );
			$( 'div.template-box' ).show( 0 ).addClass( 'templatebox-showing' );
			$( 'body' ).addClass( 'bgltemplate-open' );
			//stopBouncing(calpad);
		} else {
			$( this ).removeClass( 'item-template-active' );
			$( 'div.template-box' ).removeClass( 'templatebox-showing' );
			$( 'body' ).removeClass( 'bgltemplate-open' );
			//stopBouncing(0);
		}
	} );
	// template-close
	$( 'body' ).on( 'click', 'div.template-box a.template-close, div.template-box div.template-overlay', function ( e ) {
		$( 'div.header-items ul.lst-header-items li a.item-template' ).removeClass( 'item-template-active' );
		$( 'nav.global-nav div.navigation-items>ul.lst-navigation>li.mb-template>a' ).removeClass( 'item-template-active glnavi-active' );
		$( 'div.template-box' ).removeClass( 'templatebox-showing' );
		$( 'body' ).removeClass( 'bgltemplate-open' );
		setTimeout(function () {
			$( 'div.template-box' ).fadeOut(100);
		}, 600);
	} );

	// Filter box 
	$( 'body' ).on( 'click', 'div.filter-widget div.filter-box div.filter-header>a', function ( e ) {
		if ( !$( this ).closest( 'div.filter-widget' ).hasClass( 'fw-expanded' ) ) {
			$( this ).closest( 'div.filter-widget' ).addClass( 'fw-expanded' );
		} else {
			$( this ).closest( 'div.filter-widget' ).removeClass( 'fw-expanded' );
		}
	} );

	// Logout Sample 
	/* -- Logout modal show */
	$( 'body' ).on( 'click', 'a.btn-logout-confirm', function () {
		$( 'div#tm-logoutconfirm' ).show(1);
		$( 'div#tm-logoutconfirm' ).addClass( 'tinymodal-showing' );
	});
	$( 'body' ).on( 'click', 'div#tm-logoutconfirm a.default', function () {
		$( 'div#tm-logoutconfirm' ).removeClass( 'tinymodal-showing' );
	});

	// Spinner loading content update 
	// foreach ()
	// $( 'div.loader' ).append( '<div class="load-spinner"></div>' );
	for (var ispin = 0; ispin < 12; ispin++) {
		$( 'div.loader' ).children( 'div.load-spinner' ).append( '<div></div>' );
	}

	$( 'body' ).on( 'click', 'table.tbl-summary tr td .btn-view-summary', function () {
		scrolltoSummaryDetails();
	});


	/* go to top of page */
	$( 'body' ).on( 'click', 'a.btngotop', function ( e ) {
		$( 'html, body' ).animate( { scrollTop: 0 }, 400 );
	} );
	/* -- header compress when scroll */
	$( window ).on( 'scroll', function ( e ) {
		if ( $( window ).scrollTop() > 119 ) {
			$( 'a.btngotop' ).fadeIn();
		}
		else {
			$( 'a.btngotop' ).fadeOut();
		}
	});

	$( 'body' ).on( 'mouseleave', '#floating-nav', function ( e ) {
		//alert('code');
		console.log('leave');
		$("#floating-nav").fadeOut(500);
	});

	$.fn.delayedAction = function(options)
    {
        var settings = $.extend(
            {},
            {
                delayedAction : function(){},
                // cancelledAction: function(){},
                hoverTime: 1000                
            },
            options);
        
        return this.each(function(){
           var $this = $(this);
            $this.hover(function(){  
               $this.data('timerId',
                          setTimeout(function(){ 
                                      $this.data('hover',false);
                                      settings.delayedAction($this);
                                      },settings.hoverTime));
                $this.data('hover',true);
            },
            function(){        
                if($this.data('hover')){        
                    clearTimeout($this.data('timerId'));
                    //settings.cancelledAction($this);
                }
                $this.data('hover',false);
			});
        });
	}

})( jQuery );

// function newTest(){
// 	$('nav.global-nav div.navigation-items>ul.lst-navigation>li>a').on({
// 		mouseenter: function () {
// 			$(this).parent().find('div.subnavigation-items-new').first().fadeIn(1000);
// 		},
// 		mouseleave: function () {
// 			$(this).parent().find('div.subnavigation-items-new').first().fadeOut(1000);
// 		}
// 	});
// }

// function newTest(){
// 	$("nav.global-nav div.navigation-items>ul.lst-navigation>li>a, #floating-nav").delayedAction(
// 	//$('#hoverOverMe').delayedAction (
// 		{
// 			//console.log('coming');
// 			delayedAction: function($element){
// 				console.log($(this));
// 				$(this).css('color','red');
// 				console.log('in');
// 				$('#output').html($element.attr('id') + ' was hovered for 3 seconds');
// 				$("#floating-nav").fadeIn(500);
// 			},
// 			// cancelledAction: function($element){
// 			// 	$('#output').html($element.attr('id') + ' was hovered for less than 3 seconds');
// 			// 	$("#floating-nav").fadeOut(1000);
// 			// },
// 			hoverTime: 1000 // 3 seconds
// 		}
// 	);
// }

/* -- main container spacer for header, nav and footer */
pageWrapperSpacing();
function pageWrapperSpacing () {
	var headerHeight = $('header.global-header').height(),
		navHeight    = $('nav.global-nav').height(),
		footerHeight = $('footer.global-footer').height(),
		topPadding = 0;
	// ( $( window ).width() <= 768 ) ? topPadding = headerHeight : topPadding = headerHeight + navHeight;
	( $( window ).width() < 992 ) ? topPadding = headerHeight : topPadding = headerHeight + navHeight;
	$( 'div.page-wrapper' ).css( {
		'padding-top': topPadding + 15,
		'padding-bottom': footerHeight + 15
	} );
};
//openModal();
// function openModal(){
// 	console.log("inside");
// 	$('#myModal').modal('show');
// }

function bootgetScrollbarWidth() {
	var ClassName = {SCROLLBAR_MEASURER: 'modal-scrollbar-measure'}
	// thx d.walsh
	var scrollDiv = document.createElement('div');
	scrollDiv.className = ClassName.SCROLLBAR_MEASURER;
	document.body.appendChild(scrollDiv);
	//console.log('scrollDiv.getBoundingClientRect().width = ' + scrollDiv.getBoundingClientRect().width);
	//console.log('scrollDiv.clientWidth = ' + scrollDiv.clientWidth);
	var scrollbarWidth = scrollDiv.getBoundingClientRect().width - scrollDiv.clientWidth;
	document.body.removeChild(scrollDiv);
	return scrollbarWidth;
}; // Static

function tinyHeader () {
	if ( $(window).scrollTop() >= 10 ) {
		$( 'header.global-header' ).addClass( 'tiny-header' );
		$( 'nav.global-nav' ).addClass( 'shift-up' );
	} else {
		$( 'header.global-header' ).removeClass( 'tiny-header' );
		$( 'nav.global-nav' ).removeClass( 'shift-up' );
	}
};

var autoCloseToast, emptyToast;
function showToastMessage ( messageText, messageType, autoDismiss, dismissDuration ) {
	clearAutoCloseToast();clearEmptyToast();
	$( 'div.toast-messages' ).remove();
	if ( typeof messageType === "undefined" || messageType === null )
		messageType = 'error';
	if ( typeof autoDismiss === "undefined" || autoDismiss === null )
		autoDismiss = true;
	if (typeof dismissDuration === "undefined" || dismissDuration === null)
		dismissDuration = 5000;
	var messageHTML = '<div class="msg-toast msg-'+ messageType +'"><em>'+ messageText +'</em></div>';
	$( 'body' ).append( '<div class="toast-messages"></div>' );
	$( 'div.toast-messages' ).html( messageHTML );
	setTimeout( function () {
		$( 'div.toast-messages' ).find( '.msg-toast' ).addClass( 'msg-showing' );
	}, 300 );
	if ( autoDismiss ) {
		autoCloseToast = setTimeout( function () {
			$( 'div.toast-messages' ).find( '.msg-toast' ).removeClass( 'msg-showing' );
		}, dismissDuration );
		emptyToast = setTimeout( function () {
			$( 'div.toast-messages' ).html( '' );
		}, dismissDuration + 400 );
	} else {
		$( 'div.toast-messages' ).find( '.msg-toast' ).addClass( 'msg-close' ).append( '<div class="tm-cross"></div>' );
	}
};

function clearAutoCloseToast () {
	clearTimeout( autoCloseToast );
};

function clearEmptyToast () {
	clearTimeout( emptyToast );
};

function setModalHeight ( $element ) {
	if (typeof $element === "undefined" || $element === null) { 
		$element = $( '.modal' );
	}
	var winHeight = $( window ).height();
	$element.find( 'div.modal-content' ).css({
		'height' : winHeight,
	});
};

function dtSample () {
	//console.log(data);
	//rearrangeData = 
	var tdTblae = $( 'table#dt-sample' ).dataTable({
		'order':[],
		"columnDefs": [ {
			"targets": 0,
			"orderable": false
			} ]
		//data: data
		//"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
		//"pagingType": "full_numbers"
		//select: true,
		// language: {
		// 	// search: "Search in table:", 
		// 	zeroRecords: "No matching records found,<br/>try another search term",
		// 	// zeroRecords: "No matching records found,<br/>try another search term<img src=\"images/temp/apple-black.png\"/>",
		// 	// zeroRecords: "<div class=\"server-response error\">No matching records found, try another search term.</div>",
		// 	processing: "Ahmad...", 
		// 	lengthMenu: "Showing _MENU_ entries",
		// 	info: "Showing _START_ to _END_ of <b>_TOTAL_</b> entries",
		// 	// info:           "Affichage de l'&eacute;lement _START_ &agrave; _END_ sur _TOTAL_ &eacute;l&eacute;ments",
		// 	// infoEmpty:      "Affichage de l'&eacute;lement 0 &agrave; 0 sur 0 &eacute;l&eacute;ments",
		// 	// infoFiltered:   "(filtr&eacute; de _MAX_ &eacute;l&eacute;ments au total)",
		// 	// infoPostFix:    " AAA",
		// }
	});
	// dtsetResponsive();
	//$( 'table#dt-sample' ).wrap( '<div class="restable-box"></div>' );
	//$('th.dataTables_empty').parents('li').css('background', 'red');
};

function dtSample1 () {
	//console.log(data);
	//rearrangeData = 
	var tdTblae = $( 'table#dt-sample-1' ).dataTable({
		'order':[],
		"columnDefs": [ {
			"targets": 0,
			"orderable": false
			} ]
	});
};

function dtSample2 () {
	//console.log(data);
	//rearrangeData = 
	var tdTblae = $( 'table#dt-sample-2' ).dataTable({
		'order':[],
		"columnDefs": [ {
			"targets": 0,
			"orderable": false
			} ]
	});
};

function destroydtSample(){
	$( 'table#dt-sample' ).dataTable().fnDestroy();
}

function scrollToTop(){
	window.scroll({
		top: 0, 
		left: 0, 
		behavior: 'smooth'
	});
}

function dismissModal(){
	$('#modal-sample').modal('hide');
	$('#modal-sample-1').modal('hide');
	$('#modal-sample-2').modal('hide');
}

// function datatableRowActive(){
// 	$('body').on('click','.datatable>tbody>tr.highlight', function(){
// 		console.log('reached');
// 	});
// }

var testdata = {
	"data": [
		{
			"name": "Tiger Nixon",
			"position": "System Architect",
			"salary": "$ 320,800",
			"start_date": "2011/04/25",
			"office": "Edinburgh",
			"extn": "5421"
		},
		{
			"name": "Garrett Winters",
			"position": "Accountant",
			"salary": "$ 170,750",
			"start_date": "2011/07/25",
			"office": "Tokyo",
			"extn": "8422"
		},
		{
			"name": "Ashton Cox",
			"position": "Junior Technical Author",
			"salary": "$ 86,000",
			"start_date": "2009/01/12",
			"office": "San Francisco",
			"extn": "1562"
		},
		{
			"name": "Cedric Kelly",
			"position": "Senior Javascript Developer",
			"salary": "$ 433,060",
			"start_date": "2012/03/29",
			"office": "Edinburgh",
			"extn": "6224"
		},
		{
			"name": "Airi Satou",
			"position": "Accountant",
			"salary": "$ 162,700",
			"start_date": "2008/11/28",
			"office": "Tokyo",
			"extn": "5407"
		},
		{
			"name": "Brielle Williamson",
			"position": "Integration Specialist",
			"salary": "$ 372,000",
			"start_date": "2012/12/02",
			"office": "New York",
			"extn": "4804"
		},
		{
			"name": "Herrod Chandler",
			"position": "Sales Assistant",
			"salary": "$ 137,500",
			"start_date": "2012/08/06",
			"office": "San Francisco",
			"extn": "9608"
		},
		{
			"name": "Rhona Davidson",
			"position": "Integration Specialist",
			"salary": "$ 327,900",
			"start_date": "2010/10/14",
			"office": "Tokyo",
			"extn": "6200"
		},
		{
			"name": "Colleen Hurst",
			"position": "Javascript Developer",
			"salary": "$ 205,500",
			"start_date": "2009/09/15",
			"office": "San Francisco",
			"extn": "2360"
		},
		{
			"name": "Sonya Frost",
			"position": "Software Engineer",
			"salary": "$ 103,600",
			"start_date": "2008/12/13",
			"office": "Edinburgh",
			"extn": "1667"
		},
		{
			"name": "Jena Gaines",
			"position": "Office Manager",
			"salary": "$ 90,560",
			"start_date": "2008/12/19",
			"office": "London",
			"extn": "3814"
		},
		{
			"name": "Quinn Flynn",
			"position": "Support Lead",
			"salary": "$ 342,000",
			"start_date": "2013/03/03",
			"office": "Edinburgh",
			"extn": "9497"
		},
		{
			"name": "Charde Marshall",
			"position": "Regional Director",
			"salary": "$ 470,600",
			"start_date": "2008/10/16",
			"office": "San Francisco",
			"extn": "6741"
		},
		{
			"name": "Haley Kennedy",
			"position": "Senior Marketing Designer",
			"salary": "$ 313,500",
			"start_date": "2012/12/18",
			"office": "London",
			"extn": "3597"
		},
		{
			"name": "Tatyana Fitzpatrick",
			"position": "Regional Director",
			"salary": "$ 385,750",
			"start_date": "2010/03/17",
			"office": "London",
			"extn": "1965"
		},
		{
			"name": "Michael Silva",
			"position": "Marketing Designer",
			"salary": "$ 198,500",
			"start_date": "2012/11/27",
			"office": "London",
			"extn": "1581"
		},
		{
			"name": "Paul Byrd",
			"position": "Chief Financial Officer (CFO)",
			"salary": "$ 725,000",
			"start_date": "2010/06/09",
			"office": "New York",
			"extn": "3059"
		},
		{
			"name": "Gloria Little",
			"position": "Systems Administrator",
			"salary": "$ 237,500",
			"start_date": "2009/04/10",
			"office": "New York",
			"extn": "1721"
		},
		{
			"name": "Bradley Greer",
			"position": "Software Engineer",
			"salary": "$ 132,000",
			"start_date": "2012/10/13",
			"office": "London",
			"extn": "2558"
		},
		{
			"name": "Dai Rios",
			"position": "Personnel Lead",
			"salary": "$ 217,500",
			"start_date": "2012/09/26",
			"office": "Edinburgh",
			"extn": "2290"
		},
		{
			"name": "Jenette Caldwell",
			"position": "Development Lead",
			"salary": "$ 345,000",
			"start_date": "2011/09/03",
			"office": "New York",
			"extn": "1937"
		},
		{
			"name": "Yuri Berry",
			"position": "Chief Marketing Officer (CMO)",
			"salary": "$ 675,000",
			"start_date": "2009/06/25",
			"office": "New York",
			"extn": "6154"
		},
		{
			"name": "Caesar Vance",
			"position": "Pre-Sales Support",
			"salary": "$ 106,450",
			"start_date": "2011/12/12",
			"office": "New York",
			"extn": "8330"
		},
		{
			"name": "Doris Wilder",
			"position": "Sales Assistant",
			"salary": "$ 85,600",
			"start_date": "2010/09/20",
			"office": "Sidney",
			"extn": "3023"
		},
		{
			"name": "Angelica Ramos",
			"position": "Chief Executive Officer (CEO)",
			"salary": "$ 1,200,000",
			"start_date": "2009/10/09",
			"office": "London",
			"extn": "5797"
		},
		{
			"name": "Gavin Joyce",
			"position": "Developer",
			"salary": "$ 92,575",
			"start_date": "2010/12/22",
			"office": "Edinburgh",
			"extn": "8822"
		},
		{
			"name": "Jennifer Chang",
			"position": "Regional Director",
			"salary": "$ 357,650",
			"start_date": "2010/11/14",
			"office": "Singapore",
			"extn": "9239"
		},
		{
			"name": "Brenden Wagner",
			"position": "Software Engineer",
			"salary": "$ 206,850",
			"start_date": "2011/06/07",
			"office": "San Francisco",
			"extn": "1314"
		},
		{
			"name": "Fiona Green",
			"position": "Chief Operating Officer (COO)",
			"salary": "$ 850,000",
			"start_date": "2010/03/11",
			"office": "San Francisco",
			"extn": "2947"
		},
		{
			"name": "Shou Itou",
			"position": "Regional Marketing",
			"salary": "$ 163,000",
			"start_date": "2011/08/14",
			"office": "Tokyo",
			"extn": "8899"
		},
		{
			"name": "Michelle House",
			"position": "Integration Specialist",
			"salary": "$ 95,400",
			"start_date": "2011/06/02",
			"office": "Sidney",
			"extn": "2769"
		},
		{
			"name": "Suki Burks",
			"position": "Developer",
			"salary": "$ 114,500",
			"start_date": "2009/10/22",
			"office": "London",
			"extn": "6832"
		},
		{
			"name": "Prescott Bartlett",
			"position": "Technical Author",
			"salary": "$ 145,000",
			"start_date": "2011/05/07",
			"office": "London",
			"extn": "3606"
		},
		{
			"name": "Gavin Cortez",
			"position": "Team Leader",
			"salary": "$ 235,500",
			"start_date": "2008/10/26",
			"office": "San Francisco",
			"extn": "2860"
		},
		{
			"name": "Martena Mccray",
			"position": "Post-Sales support",
			"salary": "$ 324,050",
			"start_date": "2011/03/09",
			"office": "Edinburgh",
			"extn": "8240"
		},
		{
			"name": "Unity Butler",
			"position": "Marketing Designer",
			"salary": "$ 85,675",
			"start_date": "2009/12/09",
			"office": "San Francisco",
			"extn": "5384"
		},
		{
			"name": "Howard Hatfield",
			"position": "Office Manager",
			"salary": "$ 164,500",
			"start_date": "2008/12/16",
			"office": "San Francisco",
			"extn": "7031"
		},
		{
			"name": "Hope Fuentes",
			"position": "Secretary",
			"salary": "$ 109,850",
			"start_date": "2010/02/12",
			"office": "San Francisco",
			"extn": "6318"
		},
		{
			"name": "Vivian Harrell",
			"position": "Financial Controller",
			"salary": "$ 452,500",
			"start_date": "2009/02/14",
			"office": "San Francisco",
			"extn": "9422"
		},
		{
			"name": "Timothy Mooney",
			"position": "Office Manager",
			"salary": "$ 136,200",
			"start_date": "2008/12/11",
			"office": "London",
			"extn": "7580"
		},
		{
			"name": "Jackson Bradshaw",
			"position": "Director",
			"salary": "$ 645,750",
			"start_date": "2008/09/26",
			"office": "New York",
			"extn": "1042"
		},
		{
			"name": "Olivia Liang",
			"position": "Support Engineer",
			"salary": "$ 234,500",
			"start_date": "2011/02/03",
			"office": "Singapore",
			"extn": "2120"
		},
		{
			"name": "Bruno Nash",
			"position": "Software Engineer",
			"salary": "$ 163,500",
			"start_date": "2011/05/03",
			"office": "London",
			"extn": "6222"
		},
		{
			"name": "Sakura Yamamoto",
			"position": "Support Engineer",
			"salary": "$ 139,575",
			"start_date": "2009/08/19",
			"office": "Tokyo",
			"extn": "9383"
		},
		{
			"name": "Thor Walton",
			"position": "Developer",
			"salary": "$ 98,540",
			"start_date": "2013/08/11",
			"office": "New York",
			"extn": "8327"
		},
		{
			"name": "Finn Camacho",
			"position": "Support Engineer",
			"salary": "$ 87,500",
			"start_date": "2009/07/07",
			"office": "San Francisco",
			"extn": "2927"
		},
		{
			"name": "Serge Baldwin",
			"position": "Data Coordinator",
			"salary": "$ 138,575",
			"start_date": "2012/04/09",
			"office": "Singapore",
			"extn": "8352"
		},
		{
			"name": "Zenaida Frank",
			"position": "Software Engineer",
			"salary": "$ 125,250",
			"start_date": "2010/01/04",
			"office": "New York",
			"extn": "7439"
		},
		{
			"name": "Zorita Serrano",
			"position": "Software Engineer",
			"salary": "$ 115,000",
			"start_date": "2012/06/01",
			"office": "San Francisco",
			"extn": "4389"
		},
		{
			"name": "Jennifer Acosta",
			"position": "Junior Javascript Developer",
			"salary": "$ 75,650",
			"start_date": "2013/02/01",
			"office": "Edinburgh",
			"extn": "3431"
		},
		{
			"name": "Cara Stevens",
			"position": "Sales Assistant",
			"salary": "$ 145,600",
			"start_date": "2011/12/06",
			"office": "New York",
			"extn": "3990"
		},
		{
			"name": "Hermione Butler",
			"position": "Regional Director",
			"salary": "$ 356,250",
			"start_date": "2011/03/21",
			"office": "London",
			"extn": "1016"
		},
		{
			"name": "Lael Greer",
			"position": "Systems Administrator",
			"salary": "$ 103,500",
			"start_date": "2009/02/27",
			"office": "London",
			"extn": "6733"
		},
		{
			"name": "Jonas Alexander",
			"position": "Developer",
			"salary": "$ 86,500",
			"start_date": "2010/07/14",
			"office": "San Francisco",
			"extn": "8196"
		},
		{
			"name": "Shad Decker",
			"position": "Regional Director",
			"salary": "$ 183,000",
			"start_date": "2008/11/13",
			"office": "Edinburgh",
			"extn": "6373"
		},
		{
			"name": "Michael Bruce",
			"position": "Javascript Developer",
			"salary": "$ 183,000",
			"start_date": "2011/06/27",
			"office": "Singapore",
			"extn": "5384"
		},
		{
			"name": "Donna Snider",
			"position": "Customer Support",
			"salary": "$ 112,000",
			"start_date": "2011/01/25",
			"office": "New York",
			"extn": "4226"
		}
	]
};
var openRows = new Array();
function dtExpandableRow () {
	var table = $( '#dt-sample-ex' ).DataTable({
		"data": testdata.data,
		"responsive": true,
		// "select": "single",
		"columns": [
			{
				"className": "dt-viewdetails",
				"orderable": false, 
				"data": null, 
				"defaultContent": "", 
				"render": function () {
					return '<div class="dt-btn-viewdetails"></div><span>Opened by another user</span>'
				}
			}, 
			{ "data": "name" },
			{ "data": "position" },
			{ "data": "office" },
			{ "data": "salary" },
			{ "data": "start_date" },
			{ "data": "office" },
			{ "data": "extn" },
		], 
		"order": [[1, "asc"]]
	});
	$( 'table#dt-sample-ex tbody' ).on( 'click', 'td.dt-viewdetails', function () {
		var tr = $( this ).closest( 'tr' );
		// tr.addClass( 'iahmad-expnaded-tr' );
		var row = table.row( tr );
		if ( row.child.isShown() ) {
			// This row is already open - close it
			row.child.hide();
			tr.removeClass('dt-rowexpandable');
		} else {
			// Open this row
			// row.child( format(row.data()) ).show();
			closeOpenedRows( table, tr );
			row.child( expandedData() ).show();
			// row.addClass( 'iahmad-rowNEW' );
			tr.addClass('dt-rowexpandable').next( 'tr' ).addClass( 'dt-rowexpanded-details' );
			openRows.push( tr );
		}
	} );
	// dtsetResponsive();
	$( 'table#dt-sample-ex' ).wrap( '<div class="restable-box"></div>' );
};
function dtExpandableRowError () {
	var table = $( '#dt-sample-exerror' ).DataTable({
		"data": testdata.data,
		"responsive": true,
		// "select": "single",
		"columns": [
			{
				"className": "dt-showerror",
				"orderable": false, 
				"data": null, 
				"defaultContent": "", 
				"render": function () {
					return '<div class="dt-btn-showerror">show error</div>'
				}
			},
			{ "data": "name" },
			{ "data": "position" },
			{ "data": "office" },
			{ "data": "salary" },
			{ "data": "start_date" },
			{ "data": "office" },
			{ "data": "extn" },
		], 
		"order": [[1, "asc"]]
	});
	$( 'table#dt-sample-exerror tbody' ).on( 'click', 'td.dt-showerror', function () {
		var tr = $( this ).closest( 'tr' );
		// tr.addClass( 'iahmad-expnaded-tr' );
		var row = table.row( tr );
		if ( row.child.isShown() ) {
			// This row is already open - close it
			row.child.hide();
			tr.removeClass('dt-rowerrorexpandable');
		} else {
			// Open this row
			// row.child( format(row.data()) ).show();
			closeOpenedRowsError( table, tr );
			row.child( expandedErrorData() ).show();
			// row.addClass( 'iahmad-rowNEW' );
			tr.addClass('dt-rowerrorexpandable').next( 'tr' ).addClass( 'dt-rowexpanded-error' );
			openRows.push( tr );
		}
	} );
	// dtsetResponsive();
	$( 'table#dt-sample-exerror' ).wrap( '<div class="restable-box"></div>' );
};
function closeOpenedRows(table, selectedRow) {
	$.each(openRows, function (index, openRow) {
		// not the selected row!
		if ($.data(selectedRow) !== $.data(openRow)) {
			var rowToCollapse = table.row(openRow);
			rowToCollapse.child.hide();
			openRow.removeClass('dt-rowexpandable');
			// openRow.addClass( 'iahmad-row' );
			// replace icon to expand
			$(openRow).find('td.dt-viewdetails');
			// remove from list
			var index = $.inArray(selectedRow, openRows);
			openRows.splice(index, 1);
		}
	});
};
function closeOpenedRowsError(table, selectedRow) {
	$.each(openRows, function (index, openRow) {
		// not the selected row!
		if ($.data(selectedRow) !== $.data(openRow)) {
			var rowToCollapse = table.row(openRow);
			rowToCollapse.child.hide();
			openRow.removeClass('dt-rowerrorexpandable');
			// openRow.addClass( 'iahmad-row' );
			// replace icon to expand
			$(openRow).find('td.dt-showerror');
			// remove from list
			var index = $.inArray(selectedRow, openRows);
			openRows.splice(index, 1);
		}
	});
}
function expandedData () {
	return innerHTMLTemplate();
};

function expandedErrorData () {
	return innerHTMLErrorTemplate();
};

function dtsetResponsive () {
	/*if (!$( 'div.table-responsivebox' ).find( 'table.table.dataTable:has("div.restable-box")' ) ) {
		$( 'div.table-responsivebox' ).find( 'table.table.dataTable' ).wrap( '<div class="restable-box"></div>' );
	}*/
	$( 'div.table-responsivebox' ).each(function ( i ) {
		if ( !$( this ).find( 'table.table.dataTable:has("div.restable-box")' ) ) {
			$( this ).find( 'table.table.dataTable' ).wrap( '<div class="restable-box"></div>' );
		}
	});
	$( 'div.table-responsivebox' ).find( 'div.dataTables_filter label input[type="search"].form-control' ).attr( 'placeholder', 'Enter keyword here' );
};

function dtresizeWidth () {
	$( 'table.table.dataTable' ).width('100%');
	// table table-hover dataTable no-footer
};

function innerHTMLTemplate () {
	return '<div class="dt-exdetails-container">'
		+ '<h1 style="color:#0b6ec7;background:transparent;font-weight:400;">This is <b style="font-size: 100%;">innerHTMLTemplate</b></h1>' 
		+ '</div>';
};

function innerHTMLErrorTemplate () {
	return '<div class="dt-exerror-container">'
		+ '<h5>Show Error here</h5>' 
		+ '</div>';
};

function showPageLoader () {
	$( 'body' ).addClass( 'ploader-open' );
	$( 'div.page-loader' ).fadeIn(1).addClass( 'inprogress' );
};

function hidePageLoader () {
	$( 'body' ).removeClass( 'ploader-open' );
	$( 'div.page-loader' ).fadeOut(1000).removeClass( 'inprogress' );
};

function chartsAll () {
	// cpie-sample
	cpie();
	// cdon-sample
	cdon();
	// cline-sample
	cline();
	// cbar-sample
	cbar();
};

function cpie () {
	var adata = {
		datasets: [{
			data: [10, 20, 30], 
			backgroundColor: ['rgb(255, 99, 132)', 'rgb(50, 99, 132)', 'rgb(255, 99, 50)']
		}],
		labels: [
			'Red',
			'Yellow',
			'Blue'
		]
	};
	var ctx = document.getElementById('cpie-sample').getContext('2d');
	var myPieChart = new Chart(ctx,{
		type: 'pie',
		data: adata, 
		options: {
			legend: false
		}
	});
};
function cdon () {
	var bdata = {
		datasets: [{
			data: [10, 20, 30], 
			backgroundColor: ['rgb(255, 99, 132)', 'rgb(50, 99, 132)', 'rgb(255, 99, 50)']
		}],
		labels: [
			'Red',
			'Yellow',
			'Blue'
		]
	};
	var ctx = document.getElementById('cdon-sample').getContext('2d');
	var myPieChart = new Chart(ctx,{
		type: 'doughnut',
		data: bdata, 
		options: {
			legend: false,
			cutoutPercentage: 80
		}
	});
};
function cline () {
	var cdata = {
		labels: ["January", "February", "March", "April", "May", "June", "July"],
		datasets: [{
			label: "My First dataset",
			backgroundColor: 'rgb(10, 99, 20)',
			borderColor: 'rgb(10, 99, 20)',
			data: [0, 10, 5, 4, 20, 30, 45],
			fill: false
		}]
	};
	var ctx = document.getElementById('cline-sample').getContext('2d');
	var myLineChart = new Chart(ctx, {
		type: 'line',
		data: cdata,
		options: {
			legend: false,
			scales: {
				xAxes: [{
					// display: false
					// gridLines: {
					// 	display: false
					// }, 
					// ticks: {
					// 	display: false
					// }, 
				}], 
				yAxes: [{
					// display: false,
					// gridLines: {
					// 	display: false
					// }, 
					// ticks: {
					// 	display: false
					// }
				}]
			},
		}
	});
};
function cbar () {
	var cdata = {
		labels: ["January", "February", "March", "April", "May", "June", "July"],
		datasets: [{
			label: "My First dataset",
			backgroundColor: [ "red", "purple", "green", "yellow", "orange", "pink", "teal" ],
			data: [0, 10, 5, 4, 20, 30, 45],
			fill: false
		}]
	};
	var ctx = document.getElementById('cbar-sample').getContext('2d');
	var myLineChart = new Chart(ctx, {
		type: 'bar',
		data: cdata,
		options: {
			legend: false,
			scales: {
				xAxes: [{
					// display: false
					// gridLines: {
					// 	display: false
					// }, 
					// ticks: {
					// 	display: false
					// }, 
				}], 
				yAxes: [{
					// display: false,
					// gridLines: {
					// 	display: false
					// }, 
					// ticks: {
					// 	display: false
					// }
				}]
			},
		}
	});
};

function scrolltoSummaryDetails() {
	$( 'html, body' ).animate( {scrollTop : $( 'table.tbl-summary-details' ).offset().top - 100 }, 700 );
};