
/* 
the 5 minute Firebase tutorial only takes 5 minutes and it's fun

https://www.firebase.com/tutorial/
*/

// get all of the HTML elements yo
var els = document.getElementsByTagName('*');

// get all the tags with their element name/type, assigned name and ID
tags = [];
for (var e in els) { 
	var tag = {};

	if (els[e].tagName)
		tag.tagname = els[e].tagName;
	if (els[e].name) 
		tag.name = els[e].tagName;
	if (els[e].id)
		tag.id = els[e].id;

	tags.push(tag);
}


// init the firebase db
var db = new Firebase('https://leadfiend.firebaseio.com/');
var base = {};

// to json and back to ditch any undefined because of my crap code
base.tags = JSON.parse(JSON.stringify(tags)); 
base.ooo = JSON.parse(JSON.stringify(ooo));

// set it in the base of the fire and enjoy
db.set(base);