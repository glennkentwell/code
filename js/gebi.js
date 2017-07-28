// gebi() - A lame wrapper for document.getElementById 
// If no element with the ID you want exists, an <a> tag is created and appended 
// to the <body> so you can code as if gebi never fails!
// OK, so if you want to actually know the element you're getting is not there, 
// gebi isn't for you.
// But if you want to write code like this:
//		var header=document.getElementById('header'); 
//		header.classList.add('bighead'); 
// ...then gebi might be for you.
var gebi = id => { let d=document, el; return (el=d.getElementById(id) ? el : (id => {d.body.appendChild(el=d.createElement('a')); el.id=el.name=id; return el;})(id)); }
