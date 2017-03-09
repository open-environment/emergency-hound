angular.module('ehApp').controller('configController',

    function ($scope, $rootScope, $location, cfpLoadingBar, dbManagerService, localStorageService, dbConstants, uuidService, authService) {

        //controller initialization
        $scope.serverURL = $rootScope.serverBaseUrl;
        $scope.version = dbConstants.version;
        $scope.firstName = authService.authentication.userFirstName;
        $scope.lastName = authService.authentication.userLastName;
        $scope.phone = authService.authentication.userPhone;
        $scope.trackInd = authService.authentication.trackInd;


        //method for saving server URL 
        $scope.save1 = function () {
            console.log('updating serverURL to localstorage');
            localStorageService.set('serverURL',
                {
                    url: $scope.serverURL
                });
            $rootScope.serverBaseUrl = $scope.serverURL;
            $scope.saveState = 'Saved';
        };

        $scope.save2 = function () {
            //first update local auth data
            authService.setLocalStorage(authService.authentication.token, authService.authentication.userName, authService.authentication.userIDX, $scope.firstName, $scope.lastName, $scope.phone, $scope.trackInd);


            //then sync to server
            var userData = {
                useR_IDX: authService.authentication.userIDX,
                useR_FNAME: $scope.firstName,
                useR_LNAME: $scope.lastName,
                useR_PHONE: $scope.phone,
                tracK_IND: $scope.trackInd
            };

            console.log(userData);
            dbManagerService.syncRowToServerOnly(userData, "api/Account/SetUserData");


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