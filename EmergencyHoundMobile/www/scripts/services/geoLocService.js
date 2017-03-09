angular.module('ehApp').factory('geoLocService', ['$rootScope', 'authService', 'dbManagerService',
    function ($rootScope, authService, dbManagerService) {

        var watchID;
        var lastUpdateTime
        var minFrequency = 60 * 1000;  //60 seconds

        console.log ('geoLoc Service started');

        function _startGeoWatch()
        {
            var GeoLocOptions = { maximumAge: 250, timeout: 90000, enableHighAccuracy: true }
            watchID = navigator.geolocation.watchPosition(onSuccess, onError, GeoLocOptions);

            //stop checking after 5 seconds
            window.setTimeout(function () {
                window.navigator.geolocation.clearWatch(watchID);
            }, 5000);

            function onSuccess(position) {
                var now = new Date();
                if (lastUpdateTime && now.getTime() - lastUpdateTime.getTime() < minFrequency) {
                    return;
                }
                lastUpdateTime = now;

                var _authentication = authService.authentication;

                //only need to do this if online and authenticated
                if ($rootScope.online == true && _authentication.userIDX > 0) {
                    var userLoc = {
                        LATITUDE: position.coords.latitude,
                        LONGITUDE: position.coords.longitude
                    };
                    dbManagerService.syncRowToServerOnly(userLoc, "api/Account/SetLocation");
                    console.log(position.coords.latitude + ' sent');
                }
            };

            function onError(error) {
                console.log('code: ' + error.code + '\n' + 'message: ' + error.message + '\n');
            }
        };

        return {
            startGeoWatch: _startGeoWatch
        };

        console.log('geoLoc Service exited');

    }]);