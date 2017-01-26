angular.module('ehApp').controller('documentsController', 
    
    function ($scope, $location, $http, cfpLoadingBar, ehConstants, dbManagerService) {

        console.log('Start Documents Controller');

        $scope.incidents = [];

        cfpLoadingBar.start();

        dbManagerService.getDocuments().then(function (res) {
            $scope.documents = res;
        });

        cfpLoadingBar.complete();

        console.log('End Documents Controller');


        //get the current authentication state
//        $scope.authentication = authService.authentication;

        //redirect to login view if use is not authenticated
//        if (!$scope.authentication.isAuth) {
//            console.log('user not logged in, redirect to login page');
//            $location.path('/login');
//        }

    }

);

