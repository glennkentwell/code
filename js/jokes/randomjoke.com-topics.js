var scr=document.createElement('script');
scr.src = '' +
    "var links = document.getElementsByTagName('a');    "+
    "var topics = {};                                   "+
    "for (var l=0; l<links.length; l++) {               "+
    "    if (links[l] && links[l].href) {               "+
    "        if (typeof links[l].href === 'string') {   "+
    "            if (links[l].href.indexOf('topic') === 0) {    "+
    "                topics[links[l].innerText] = links[l].href;"+
    "            }                                         "+
    "        } else {                                   "+
    "            topics['link-' + l] = links[l].innerText + ' fucken'; "+
    "        }    " +
    "    }        " +
    "}            ";
document.body.appendNode(scr);

