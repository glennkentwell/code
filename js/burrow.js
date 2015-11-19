
// a recursive function that examines the shit out of everything

function burrow(o, level) {
    var indent='   ';
    if (typeof level === 'undefined')
        level = 0;
    while (indent.length < level)
        indent += indent;
    indent = indent.slice(0, level);    // now trim it
    console.log('level=' + level + ' indent.length=' + indent.length);

    console.log(typeof o);
    for (var p in o) {
        console.log(indent + p + ' ' + typeof(this[p]));
    }
}


burrow(this);

