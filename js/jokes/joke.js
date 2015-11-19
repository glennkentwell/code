#!/usr/local/bin/node

// get a joke from the internet. You can specify sources in ~/.config/jokes.conf
var APP_NAME = 'jokegopher';
var CONFIG_FILE_LOCATIONS = [
    '~/.config/' + APP_NAME + '/',
    '/etc/' + APP_NAME + '/',
    '~/.' + APP_NAME + ',
];

var JOKE_PROVIDERS = [
    {
        name: 'randomjoke.com assorted',
        url: 'http://www.randomjoke.com/topic/haha.php',
        cssSelector: '',    // TODO: implement
        jsonProperty: '',   // TODO: implement
        xpathSelector: ''   // TODO: implement
                            // http://www.w3schools.com/xpath/xpath_examples.asp
    },
    {
        name: 'www.jokebuddha.com',
        url: 'http://www.jokebuddha.com/random',
        cssSelector: 'p.joke-inner'
        // <p class="joke-inner">A very well-built young blonde was lying on her psychiatrist's couch,<br>telling<br>him how frustrated she was.<br>"I tried to be an actress and failed," she complained. "I tried to be a<br>secretary<br>and failed; I tried being a writer and failed; then I tried being a sales<br>clerk and I failed at that, too."<br>The shrink thought for a moment and said... "Everyone needs to live a<br>full,<br>satisfying life. Why don't you try nursing?"<br>The blonde thinks about this, then bares one of her large, beautiful<br>breasts,<br>points it at the shrink, and says... "Well go ahead, I'll give it a try!"</p>
    },
    {
        name: 'jokz.net',
        url: 'http://www.jokz.net/randomJoke.php',
        cssSelector: 'center table td:nth-child(3)'
    },
    {
        name: 'dickless.org insult generator',
        url: 'http://www.dickless.org/api/insult.xml',
        xpathSelector: '//insults/insult/[text()]'
        /*
            <insults>
               <status code="200" message="OK"/>
                <insult>
                    Well, they do say opposites attact...so I sincerely hope you meet somebody  who is attractive, honest, intelligent, and cultured.
                </insult>
            </insults>
        */
    },
    {
        name: 'jokes from twitter somehow, using their API',
        url: 'https://twitter.com/Joke_OfTheDay',
        // not sure how this is gonna work yaknow   
    },
    {
        name: 'ICNDb.com - internet chuck norris database',
        url: 'http://api.icndb.com/jokes/random',
        jsonProperty: 'joke'
            /*
            { "type": "success", "value": { "id": 268, "joke": "Time waits for no man. Unless that man is Chuck Norris." } }
            */
    }
];

var fs = require('fs');

for (var cfl=0; cfl<CONFIG_FILE_LOCATIONS.length; cfl++) {
    var configFiles = fs.readdirSync('~/.config/jokegopher/');

}

// https://github.com/gagle/node-properties
var properties = require('properties');
properties.parse('~/.config/jokes', { path: true }, function (error obj) {
    if (error)
        return console.error(error);

    console.log(obj);
});

var http = require('http');
http.get(
