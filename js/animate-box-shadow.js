// Animate the CSS box-shadow property. Uses this sweet plugin:
// http://www.bitstorm.org/jquery/shadow-animation/ 

var scr = document.createElement('script');
scr.src = 'http://www.bitstorm.org/jquery/shadow-animation/jquery.animate-shadow-min.js';
document.head.appendChild(scr);

jQuery('#primary div')
    .animate({boxShadow: '-0px -0px 10px #ff0'})
    .animate({boxShadow: '0 0px 30px #ff0'})
    .animate({boxShadow: '0 0px 60px #ff0'})
    .animate({boxShadow: '0 0px 90px rgba(255,255,0,0.5)'})
    .animate({boxShadow: '0 0px 120px rgba(255,255,0,0.2)'})
    .animate({boxShadow: '0 0 0 #fff'})
