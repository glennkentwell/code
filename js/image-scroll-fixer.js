/* when you're browsing long pages of images, it's 
	annoying to manually scroll so each image exactly
	fits on your screen.
	This script checks if you've scrolled half past an
	image and backs you up a bit
*/
(function () {
    $ = jQuery;
	var scrollfix = function () {
		$('img').each(function () {
			if ($(this).hasClass('attachment-full')) {
				var wTop = $(window).scrollTop();
				var iTop = $(this).offset().top;
				var iBot = $(this).outerHeight() + iTop;
				if (iTop < wTop && iBot > wTop) {
				   $(window).scrollTop(iTop - 5);
				}
			}
		});
	};

	var scrolls = [];
	// on scroll, wait 250ms and check if stopped scrolling, then fix
	$(window).bind('scroll', function () {
		var chkTop = $(window).scrollTop();
		var getPrevTop = function () { var newChk = chkTop; return newChk; }	/* closure and new variable freezes value?*/
		setTimeout(function () {
			console.log($(window).scrollTop() + ' ' + chkTop + ' ' + getPrevTop());
			if ($(window).scrollTop() === chkTop) {
				console.log('win=' + $(window).scrollTop() + ' chk=' + chkTop);
				scrollfix();
			}
		}, 250);
	});
})();
