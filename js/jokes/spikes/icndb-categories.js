
var fs = require('fs');

var strCategories = fs.readFileSync('icndb-categories.json', { encoding: 'utf-8' });
var categories = JSON.parse(strCategories);

var count=0;
for (var c in categories) {
    console.log(++count + ' ' + c);
}

console.log("\nTotal of " + count + ' categories!');



console.log('single quote: ' + 'tab\tnewline\nyay');
console.log('double quote: ' + "tab\tnewline\nyay");

