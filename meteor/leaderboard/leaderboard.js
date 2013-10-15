// Set up a collection to contain player information. On the server,
// it is backed by a MongoDB collection named "players".

Players = new Meteor.Collection("players");

function reset_scores() {
	// can only update each by ID from client
	Players.find().forEach(function (playa) {
	  Players.update(playa._id, {$set: {score: random_score()}} );
	});
}
function random_score() { 
	return Math.floor(Random.fraction()*10)*5;
}

if (Meteor.isClient) {
  Template.leaderboard.players = function () {
	  //alert($('.sortby').first().val());
	//if (Session.get('sort')==='name') 
//		return Players.find({}, {sort: {name: 1, score, -1}});
	//else 
	return Players.find({}, 
		Session.get('sort') || {sort: {score: -1, name: 1}});
  };

  Template.leaderboard.selected_name = function () {
    var player = Players.findOne(Session.get("selected_player"));
    return player && player.name;
  };

  Template.player.selected = function () {
    return Session.equals("selected_player", this._id) ? "selected" : '';
  };

  Template.leaderboard.events({
    'click input.inc': function () {
      Players.update(Session.get("selected_player"), {$inc: {score: 5}});
    },
	'click input.del': function () {
	  Players.remove(Session.get("selected_player"), function (a) {
		console.log('error callback');
		console.log(a);  
	  });
	},
	'click input.rnd': function () {
	  reset_scores();
	},
	'change select': function (e) {
		if (e.target.options[e.target.selectedIndex].value==='name') 
			Session.set('sort', {sort: {name: 1, score: -1}});
		else
			Session.set('sort', {sort: {score: -1,name: 1}});
	},
	'submit #add': function (e) {
		Players.insert({ name: $('#addname').val(), score: random_score() });
		$('#addname').val('').focus();
		e.stopPropagation();
		return false;
	}
  });

  Template.player.events({
    'click': function () {
      Session.set("selected_player", this._id);
    }
  });
}

// On server startup, create some players if the database is empty.
if (Meteor.isServer) {
  Meteor.startup(function () {
    if (Players.find().count() === 0) {
      var names = ["Ada Lovelace",
                   "Grace Hopper",
                   "Marie Curie",
                   "Carl Friedrich Gauss",
                   "Nikola Tesla",
                   "Claude Shannon",
				   "Some Stupid Fuckhead"
				   ];
      for (var i = 0; i < names.length; i++)
        Players.insert({name: names[i], score: Math.floor(Random.fraction()*10)*5});
    } else { 
		//(Players.find()).forEach(function (playa) {
		//	Players.remove(playa);
		//});
		console.log('super server consoleout');
	}

	Players.allow({
		insert: function () { return true; },
		update: function () { return true; },
		remove: function () { return true; },
		//fetch: ['owner']
	});
  });
}
