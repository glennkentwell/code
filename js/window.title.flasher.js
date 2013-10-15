
(function () {
	function spintitle () { 
		if (window.blurred) {
			var w = ['wtf','bbq','omg','hey','oops','hey'];
			document.title = w[Math.floor(Math.random() * (w.length-1))];
		}
		setTimeout(function () { spintitle(); }, 500);
	}
	window.onblur = function () { window.blurred = true; }
	window.onfocus = function () { window.blurred = false; }
	spintitle();
})();
