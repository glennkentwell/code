// ==UserScript==
// @name       GK's seek cleaner upper fing
// @namespace  http://g3k.in/
// @version    0.01
// @description  cleans Seek job listing pages - removes ALL THE THINGS except for the job info
// @match      *://*.seek.com.au/job/*
// @copyright  2014, LennyK
// ==/UserScript==

$('.tempborder').find('img').remove();
var jh = $('.tempborder').html();
//$('div').remove();
$('body').html('').html(jh).css('background', 'white');
$('*').css('font-size','3.5mm').css('font-weight', 'normal');
$('.tempborder').css('max-width','10cm');

console.log('Seek cleaned by ' + GM_info.script.name);