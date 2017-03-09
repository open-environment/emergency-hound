angular.module('ehApp').factory('authService', ['$rootScope', '$http', '$q', 'localStorageService', 'ehConstants',
    function ($rootScope, $http, $q, localStorageService, ehConstants) {
    
        'use strict';

        console.log('authenication begins');

        var authServiceFactory = {};

        //initialize authentication state
        var _authentication = {
            isAuth: false,
            userName: '',
            token: '',
            userIDX: 0,
            userFirstName: '',
            userLastName: '',
            userPhone: '',
            trackInd: false
        };

        function _login(loginData) {
            if ($rootScope.online) {
                console.log('authentication: device is online')
                return _logInOnline(loginData);
            } else {
                console.log('authentication: device is offline')
                return _logInOffline(loginData);
            }
        };

        //authentication logic if the device if offline
        function _logInOffline(loginData) {
            var deferred = $q.defer();

            dataLocalService.getUser(loginData.userName)
                .then(function (user) {
                    if (!user) {
                        console.log('SIGNIN OFFLINE: error');
                        deferred.reject();
                        return;
                    }
                    var decPassword = alphac(
                        user.password, user.token, md5(user.token), 0);

                    if (decPassword === loginData.password) {

                        // set current user in local storage
                        _setLocalStorage(user.token, loginData.userName, user.roles);

                        console.log('SIGNIN OFFLINE: success');
                        deferred.resolve();
                    } else {
                        console.log('SIGNIN OFFLINE: error');
                        deferred.reject();
                    }
                })
                .catch(function (error) {
                    deferred.reject(error);
                });

            return deferred.promise;
        };

        //authentication logic if the device is online
        function _logInOnline(loginData) {
            var deferred = $q.defer();

            $http.get($rootScope.serverBaseUrl + 'api/account/ValidateUser?username=' + loginData.userName + '&password=' + loginData.password)
                .success(function (response) {
                    if (response.isValid == "true") {
                        // set current user in local storage
                        console.log('Authenticated to server succeeded');
                        _setLocalStorage(response.authToken, loginData.userName, response.userIDX, response.userFirstName, response.userLastName, response.userPhone, response.trackInd);
                        deferred.resolve();
                    }
                    else {
                        console.log('Authentication to server failed');
                        deferred.reject('ee');
                        authServiceFactory.logOut();    
                    }
                }
            ).error(function (err) {
                console.log(err);
                authServiceFactory.logOut();
                deferred.reject(err);
            });

            return deferred.promise;
        };

        // set current user in local storage
        function _setLocalStorage(token, userName, userIDX, userFirstName, userLastName, userPhone, trackInd) {

            localStorageService.set('authorizationData',
                {
                    token: token,
                    userName: userName,
                    userIDX: userIDX,
                    userFirstName: userFirstName,
                    userLastName: userLastName,
                    userPhone: userPhone,
                    trackInd: trackInd
                }
            );
            _authentication.isAuth = true;
            _authentication.userName = userName;
            _authentication.token = token;
            _authentication.userIDX = userIDX;
            _authentication.userFirstName = userFirstName;
            _authentication.userLastName = userLastName;
            _authentication.userPhone = userPhone;
            _authentication.trackInd = trackInd;
        };

        var _logOut = function () {
            localStorageService.remove('authorizationData');

            _authentication.isAuth = false;
            _authentication.userName = '';
            _authentication.token = '';
            _authentication.userIDX = 0;
            _authentication.userFirstName = '';
            _authentication.userLastName = '';
            _authentication.userPhone = '';
            _authentication.trackInd = false;
        };

        var _fillAuthData = function () {
            var authData = localStorageService.get('authorizationData');
            if (authData) {
                _authentication.isAuth = true;
                _authentication.userName = authData.userName;
                _authentication.token = authData.token;
                _authentication.userIDX = authData.userIDX;
                _authentication.userFirstName = authData.userFirstName;
                _authentication.userLastName = authData.userLastName;
                _authentication.userPhone = authData.userPhone;
                _authentication.trackInd = authData.trackInd;
            }
        };

        authServiceFactory.login = _login;
        authServiceFactory.logOut = _logOut;
        authServiceFactory.fillAuthData = _fillAuthData;
        authServiceFactory.authentication = _authentication;
        authServiceFactory.setLocalStorage = _setLocalStorage;

        return authServiceFactory;

    }]);
