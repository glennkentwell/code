String.prototype.rotate = function (numchars) { 
	return this.substr(numchars, this.length-numchars) + this.substr(0,numchars);
}
