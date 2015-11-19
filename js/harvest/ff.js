var images = []; 
setInterval(function () {
var el = document.getElementsByTagName('div');
for (var i=0; i<el.length; i++) { if (el[i].getAttribute('data-imageurl')) images.push(el[i].getAttribute('data-imageurl')); }
window.scrollBy(0, window.innerHeight);
console.log('and scroll... ' + images.length);
}, 3000);


var urls = []; 
var prevlen = 0;
setInterval(function () { 
	var els = document.getElementsByTagName('*');
	window.scrollBy(0, window.innerHeight);
	for (var e=0; e<els.length; e++) { 
		var iu=''; 
		if (iu=els[e].getAttribute('data-imageurl')) 
			urls.push(iu);
	}
	
	// REMOVE DUPES
	var urls2 = urls.sort();
	for (var u=1; u<urls2.length; u++) { if (urls2[u]==urls2[u-1]) delete urls2[u]; }
	urls = urls2;

	// write url list to pre tag at bottom
	if (!document.getElementsByTagName('pre')) {
		var pre = document.createElement('pre');
		pre.style.position = 'fixed';
		pre.style.top = '100px';
		pre.style.left = '0';
		pre.style.width = '200px';
		pre.style.height = '200px';
		pre.style.background = '#878';		
		document.body.appendChild(pre);
	}
	var pre = document.getElementsByTagName('pre')[0];
	pre.innerText = JSON.stringify(urls);
}, 1000);







var urls = []; 
var prevlen = 0;
setInterval(function () { 
	var els = document.getElementsByTagName('*');
	window.scrollBy(0, window.innerHeight);
	for (var e=0; e<els.length; e++) { 
		var iu=''; 
		if (iu=els[e].getAttribute('data-imageurl')) 
			urls.push(iu);
	}
	
	// REMOVE DUPES
	var urls2 = urls.sort();
	for (var u=1; u<urls2.length; u++) { if (urls2[u]==urls2[u-1]) delete urls2[u]; }
	urls = urls2;

	var x = new window.XMLHttpRequest();
	x.open('POST', 'http://chief:8888/');
	x.send(JSON.stringify(urls));

}, 1000);
