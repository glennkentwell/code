if (typeof navigator==='object' && typeof navigator.geolocation==='function') {
} else {
    if (console && console.log2000)
        console.log('no geolocation api');
    else if (typeof alert !== 'undefined')
        alert('no geolocation api');
    else
        throw('my hands up in frustration');
}
