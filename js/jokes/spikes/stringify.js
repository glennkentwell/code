/*
    A little bit of a spike to mess with JSON.stringify()
    and different character encodings, then in my travels 
    I learned about the 'replacer' parameter of stringify()
    as well as the 'space' parameter that causes it to nicely
    format the json

    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_native_JSON#section_2

    Also some info on determining character encoding from the shell
    http://mindspill.net/computing/linux-notes/determine-and-change-file-character-encoding/
    file -i somefile.txt  # check the encoding
    iconv -l              # lists all the encodings it knows
    iconv -c              # omits invalid characters from input
    iconv -f utf8 -t ascii [filename] # change the encoding
*/

//
//  set yo constants
//
var WHITESPACE = 4;     // how many chars of whitespace to have

var MAX_PROPERTIES = 50;                // max # of properties our object can have
var MAX_PROPERTY_NAME_LENGTH = 32;      // max length of a property name
var MAX_PROPERTY_VALUE_LENGTH = 1000;   // max length of the property's value

//
// require yo modules 
//
var crypto=require('crypto');

/* define a little lib function */
function randomInt(max) {
    return Math.floor(Math.random() * max);
}

var replacers = [];
replacers.push(function (key, value) {
   // replace any character with its ordinal number aka charCodeAt
   if (typeof value === 'string' || typeof value === 'number') {
        var s = value.toString();
        var snew = '';
        for (var c=0; c<s.length; c++) {
           snew += s.charCodeAt(c) + ' ';
        }
   }
   return snew;
},
function (key,value) {
    // replace every number with '69'
    if (typeof value === 'number') {
        return 69;
    }
});

//
// Now actually do some business. The plan is just to
// create an object and add a bunch of random property names with random values
//

var o={};

// create some random number of properties between 0 and 50
var numProps = randomInt(MAX_PROPERTIES);
for (var x=0; x<numProps; x++) {
    // actually base64 causes it to be longer, should probly trim it
    var propName = crypto.randomBytes(randomInt(MAX_PROPERTY_NAME_LENGTH)).toString('base64');
    
    o[propName + 'base64'] = crypto.randomBytes(randomInt(MAX_PROPERTY_VALUE_LENGTH)).toString('base64');
    o[propName + 'utf8'] = crypto.randomBytes(randomInt(MAX_PROPERTY_VALUE_LENGTH)).toString('utf-8');
}

// choose a random replacer function
var fnReplacer = replacers[ randomInt(replacers.length-1) ];

// console.log(JSON.stringify(o, fnReplacer, WHITESPACE));

module.exports.o = o;
