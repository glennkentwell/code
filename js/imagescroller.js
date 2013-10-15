(function () {
	if ($ || jQuery) {
		$ = jQuery;
		var imgs = $('img');
		var i=0;
		while (i < imgs.length && 
			(($(imgs[i]).offset() && $(imgs[i]).offset().top)
				&&  $(imgs[i]).offset().top > window.scrollY)) {
			i++;
		}
		window.scrollTo($(imgs[i]).offset().top);
	} else {
		console.log('soz need jquery. should import it fo real');
	}
})();
