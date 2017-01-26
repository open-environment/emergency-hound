angular.module('ehApp').controller('configController',

    function ($scope, $rootScope, $location, cfpLoadingBar, dbManagerService, localStorageService, dbConstants, uuidService) {

        //controller initialization
        $scope.serverURL = $rootScope.serverBaseUrl;
        $scope.version = dbConstants.version;

        //method for saving page
        $scope.save1 = function () {
            console.log('updating serverURL to localstorage');
            localStorageService.set('serverURL',
                {
                    url: $scope.serverURL
                });
            $rootScope.serverBaseUrl = $scope.serverURL;
            $scope.saveState = 'Saved';
        };

        // method for deleting database
        $scope.delDB1 = function () {
            dbManagerService.delDB();
            localStorageService.remove('syncpull');
        };

        // method for sync pull on demand
        $scope.syncing = function () {
            dbManagerService.sync();
        };

    }
);