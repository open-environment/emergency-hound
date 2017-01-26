angular.module('ehApp').controller('confirmController',

    function ($scope, $rootScope, $location, cfpLoadingBar) {

        //method for saving page
        $scope.rtn = function () {
            console.log('returning to dashboard');
            $location.path('/dashboard');

        };


    }
);