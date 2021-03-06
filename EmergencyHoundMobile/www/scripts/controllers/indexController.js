﻿angular.module('ehApp').controller('indexController', ['$scope', '$rootScope', '$location', 'ehConstants', 'authService', 'dbManagerService', 'geoLocService', 

    function ($scope, $rootScope, $location, ehConstants, authService, dbManagerService, geoLocService) {

        console.log('index controller start');

        //get the current authentication state
        $scope.authentication = authService.authentication;

        //redirect to login view if use is not authenticated
        if (!$scope.authentication.isAuth) {
            console.log('user not logged in, redirect to login page');
            $location.path('/login');
        }
        else {
            //console.log('user is ' + $scope.authentication.userName);
            //console.log('token ' + $scope.authentication.token);
            //console.log('userIDX iss ' + $scope.authentication.userIDX);

            $rootScope.token = $scope.authentication.token;

            //if authenticated, then perform sync
            console.log('starting data sync from server');
            dbManagerService.sync();

            $location.path('/dashboard');
        }

        $scope.needSync = $rootScope.needSync;


        //method when logout link is clicked
        $scope.logOut = function () {
            authService.logOut();   
            $location.path('/login');
        };

        $scope.pushSync = function () {
            //submit all pending people
            dbManagerService.getDataByIndex('people', 'synced', 0).then(function (res) {

                //submit all pending incidents
                dbManagerService.getDataByIndex('incidents', 'synced', 0).then(function (res2) {

                    //submit all pending resources
                    dbManagerService.getDataByIndex('resources', 'synced', 0).then(function (res3) {
                    });
                });
            });

        };

        //start the geolocation tracker *************************************************
//        geoLocService.startGeoWatch();
        window.setInterval(function () {
            geoLocService.startGeoWatch();
        },
        30000 //check every 30 seconds
        );
        //end the geolocation tracker *************************************************



        console.log('index controller end');

    }


]);
