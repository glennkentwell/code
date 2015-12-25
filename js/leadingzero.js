// just a little function to add a leading zero to a single-digit
// numeric value...most useful for formatting time/date strings

function lz(val) {
	if (!val)
		return '00';
	
	if (val.toString().length < 2)
		return '0' + val;
}
