#!/usr/local/bin/node



var joke = "Jokz.net ▶ Relationships ▶ What a Woman Really Needs


What a Woman Really Needs

A couple was having some trouble, so they did the rightthing and went to a marriage counselor. 


After a few visits, and a lot of questioning and listening, the counselor saidthat he had discovered the main problem. 

He stood up, went over to the woman, asked her to stand, and gave her a hug. 
He looked at the man and said, "thisis what your wife needs, at least once a day! "

The man frowned, thought for a moment, then said, "Ok, whattime do you want me to bring her back tomorrow? ".
  


A Caring Husband ▶
A Guy Is Down On His Luck. He Takes His Last $500... ▶
I'll Never Forget The First Time I Saw My Husband... ▶
What Was The First Thing Your Husband Said To You... ▶
Why Are Bachelors Thin, And Married Men Fat? ▶

";

var out = '';
for (var c=0; c<joke.length; c++) {
    out += c + ' ' + joke[c] + ' ' + ord(joke[c]) + '\n';
}
console.log(out);

