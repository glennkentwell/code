(function () {

	this.qs = function () {}
		var params = {};
		var s = window.location.search.match(/[^?].*/)[0].split('&');
		for (var i=0; i<s.length; i++) {
		    if (typeof s[i] === 'string') {
		        params[tmp[0]] = (s[i].split('='))[1];
		    }
		}
		return params;
	};

	this.downapk = function (apk_id) {
		var dest = 'http://apps.evozi.com/apk-downloader/?id=' + apk_id;
		window.open(dest);
	};

	var params = this.qs();
	if (params && params.id)
		this.downapk(params.id);

})();