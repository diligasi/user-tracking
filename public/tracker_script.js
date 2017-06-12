// To prevent conflict issues this script must be imported after all
// scripts on partner's site.

var CookieHandler = (function() {
    // var serverUrl = 'http://192.168.0.111:3001/cookie',
    var serverUrl = 'https://dili-user-tracker.herokuapp.com/cookie',
        cookieName = '_client.cookie';

    var requestServer = function() {
        var httpRequest = new XMLHttpRequest();
        httpRequest.onreadystatechange = onRequestComplete;
        httpRequest.open('POST', serverUrl, true);
        httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
        httpRequest.withCredentials = true;
        httpRequest.send();
    };

    var onRequestComplete = function() {
        if (this.readyState === 4 && this.status === 200) {
            createCookie(this.responseText);
            if (window.location.pathname === '/contato') {
                var cookie = getCookie(),
                    input = document.createElement('input');

                input.setAttribute('type', 'hidden');
                input.setAttribute('name', 'tracker_id');
                input.setAttribute('value', cookie.id);
                document.getElementsByTagName('form')[0].appendChild(input);
            }
        }
    };

    var createCookie = function(value) {
        document.cookie = cookieName + '=' + value;
    };

    var getCookie = function() {
        var re = new RegExp(cookieName + "=([^;]+)");
        var value = re.exec(document.cookie);
        return (value != null) ? JSON.parse(unescape(value[1])) : null;
    };

    var init = function() {
        requestServer();
    };

    return {
        init : init
    };
})();

window.addEventListener('load', CookieHandler.init);
