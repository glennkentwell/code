/*
  Make a bookmarklet from a string of Javascript,
  set that javascript: URL as the current window's
  location, and log it to the console as well
*/

(function (guts) {
	
	var bkmklet = 'javascript:' + encodeURIComponent(guts);

	if (console && console.log) console.log(bkmklet);
	if (window) window.location = bkmklet;
		
})( 
	'var links=document.getElementsByTagName("a"); ' +
	'for (var l in links) ' +
	'	if (links[l] && links[l].href)	 ' +
	'		console.log(links[l].href);	 '
  );

var guts="$('#fader,.popup').remove()";
