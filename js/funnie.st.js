var imgurls = [];

var imgs = document.getElementsByClassName('secureimg_wp');
for (var i in imgs) {
	if (imgs[i].src && imgs[i].src.indexOf('wp-content') > 0) 
		imgurls.push(imgs[i].src);
}

while (true) {
	var nextlinks = document.getElementsByClassName('next-previous');
	if (nextlinks.childNodes && nextlinks.childNodes.length) { 
		var nxt = nextlinks.childNodes[nextlinks.childNodes.length-1];
		console.log(nxt);

		// get img and move on
		var xhr = new XMLHttpRequest();
		xhr.open('GET', nxt);
		xhr.onload = function () {
			var div = document.createElement('div');
			div.innerHTML = this.responseText;
			var imgs = document.getElementsByTagName('img'); //'secureimg_wp');
			for (var i in imgs) {
				imgurls.push(imgs[i].src);
			}
		}
		xhr.send();
	}
}

