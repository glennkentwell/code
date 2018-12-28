url="http://192.168.1.230/api"

if [ -z response.json ]; then
	curl -so response.json --data '{ "devicetype": "somedumbapp" }' $url

	# process auth response; get username
	if [ $( grep -c error response.json ) -ne 0 ]; then
		echo "Error:"
		cat response.json | jq ".[].error"

		exit 1
	fi
fi

username=$( cat response.json | jq -r ".[].success.username" )
echo username is $username

# get state about light #1
# curl $url/$username/lights/1/state | jq "."

sleep 1

function putState() {
	curl -sX PUT --data "$1" "$url/$username/lights/1/state"
}

if [ "$1" == "-t" ] || [ "$1" == "--test" ]
then

	# turn off
	putState '{ "on": false }'

	sleep 1

	# turn on
	putState '{ "on": true }'
	#curl -sX PUT --data '{ "on": true }' $url/$username/lights/1/state 

	sleep 1

	# set brightness to 50 (max 255)
	putState '{ "bri": 100 }'
	# curl -sX PUT --data '{ "bri": 50 }' $url/$username/lights/1/state 

	sleep 1

	# set h,s,b
	putState '{ "hue": 5000 }'
	# curl -sX PUT --data '{ "h": 50 }' $url/$username/lights/1/state 
fi

#loop
# while true; do putState '{ "alert": "select" }'; putState "{\"hue\": $( echo $(( $RANDOM % 8000 )) ), \"bri\": $( echo $(( $RANDOM % 255 )) ) }"; sleep 10; done