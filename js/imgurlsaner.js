
var saveimg = function (imgurl) { 
	var safename = decodeURIComponent(imgurl).replace(/[\:\/\ ]+/g, '_');
	var elSafeo = document.createElement('<div>' + safename + '</div>')
	document.body.appendChild(elSafeo);
}
