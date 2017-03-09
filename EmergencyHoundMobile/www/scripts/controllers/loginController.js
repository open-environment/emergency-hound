angular.module('ehApp').controller('loginController',
    
    function ($scope, $rootScope, authService, cfpLoadingBar, $location) {

        console.log('Start Login Controller');

        $scope.message = '';
        $scope.loginData = {
            userName: '',
            password: ''
        };

        
        $scope.login = function () {
            //START VALIDATION
            if (!$scope.loginForm.$valid) {
                return;
            }
            //END VALIDATION

            cfpLoadingBar.start();

            var loginPromise = authService.login($scope.loginData);

            loginPromise.then(function () {
                console.log('login success');

                var auth1 = authService.authentication;
                console.log('user is ' + auth1.userName);
                console.log('token ' + auth1.token);
                console.log('useridx ' + auth1.userIDX);

                $rootScope.token = auth1.token;
                $rootScope.userIDX = auth1.userIDX;

                //var syncPromise = dataSyncService.sync();

                //syncPromise.then(function () {
                //    console.log('initial sync success');

                $location.path('/dashboard');
                //});
                //syncPromise.catch(function () {
                //    console.log('initial sync error');
                 //   $scope.message = 'Error logging in';
                //});
            });
            loginPromise.catch(function () {
                $scope.message = 'Error logging in';
                cfpLoadingBar.complete();
                $location.path('/login');
            });

        };


        $scope.logOut = function () {
            authService.logOut();
            $location.path('/login');
        };

        console.log('End Login Controller');

    }
);
