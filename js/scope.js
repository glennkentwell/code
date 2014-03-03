/*
an experiment in javascript scoping
*/

function append(txt) {
	var div = document.createElement('div');
	div.innerHTML = txt;
	document.body.appendChild(div);
	return div;
}

var o = {};
(function (glob) {
    var onething = 'onething';		// private
    this.another = 'another';		// public
    
    this.fun = function () {		// public function
        return onething;   
    }
    function fun2 () {				// private function
        return this.another;
    }
    this.fun3 = function () {		// public function that calls a private one
        return fun2();
    }
    
    glob.scopey = this;
})(o);


append(o.scopey.fun());				// call the public function - no worries
if (o.scopey.fun2) {
	append(o.scopey.fun2());		// if we can see the private function, call it (we can't)
}
append(o.scopey.fun3());			// call the public function that calls the privaste one (works a treat!)