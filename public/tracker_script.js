// To prevent conflict issues this script must be imported after all
// scripts on partner's site.

var CookieHandler = (function() {
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
                var cookie = JSON.parse(readCookie()),
                    input = document.createElement('input');

                input.setAttribute('type', 'hidden');
                input.setAttribute('name', 'tracker_id');
                input.setAttribute('value', cookie.id);
                document.getElementsByTagName('form')[0].appendChild(input);
            }
        }
    };

    var createCookie = function(value) {
        var ownerPath = '; path=' + window.location.pathname;
        document.cookie = cookieName + '=' + value + ownerPath + ';';
    };

    var readCookie = function() {
        var cookieArr = document.cookie.split(';');
        for(var i = 0; i < cookieArr.length; i++) {
            var cookie = cookieArr[i];
            while (cookie.charAt(0) == ' ') {
                cookie = cookie.substring(1, cookie.length);
            }
            if (cookie.indexOf(cookieName) == 0) {
                return cookie.substring(cookieName.length, cookie.length);
            }
        }
    };

    var init = function() {
        requestServer();
    };

    return {
        init : init
    };
})();

window.addEventListener('load', function() {
    if (document.cookie === "") {
        CookieHandler.init();
    }
});
