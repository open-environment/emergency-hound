(function () {
    'use strict';

    //define angular application name and modules that are used
    var app = angular.module('ehApp',
        [
            'ngRoute',   //used for routing
            'angular-loading-bar',  //cfp loading bar
            'LocalStorageModule'   //helper module for using Local Storage
        ]
    );

    //****************************************************************************
    //DEFINE APPLICATION CONSTANTS
    //****************************************************************************
    app.constant('ehConstants', {
        appId: 'ehApp',
        selectedIncident: null,
        selectedIncidentStatus: null,
        selectedResource: null,
        selectedPerson: null,
        selectedQual: null
    });

    app.constant('dbConstants', {
        name: 'emergency_hound',
        version: 4
    });

    //****************************************************************************
    //DEFINE APPLICATION ROUTING
    //****************************************************************************
    app.config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'views/dashboard.html',
                controller: 'dashboardController' 
            })
            .when('/index', {
                templateUrl: 'views/dashboard.html',
                controller: 'dashboardController'
            })
            .when('/login', {
                templateUrl: 'views/login.html',
                controller: 'loginController'
            })
            .when('/dashboard', {
                templateUrl: 'views/dashboard.html',
                controller: 'dashboardController'
            })
            .when('/resources', {
                templateUrl: 'views/resources.html',
                controller: 'resourcesController'
            })
            .when('/resourceEdit2', {
                templateUrl: 'views/resourceEdit2.html',
                controller: 'resourceEdit2Controller'
            })
            .when('/resourceVerify', {
                templateUrl: 'views/resourceVerify.html',
                controller: 'resourceVerifyController'
            })
            .when('/people', {
                templateUrl: 'views/people.html',
                controller: 'peopleController'
            })
            .when('/personEdit', {
                templateUrl: 'views/personEdit.html',
                controller: 'personEditController'
            })
            .when('/qualificationEdit', {
                templateUrl: 'views/qualificationEdit.html',
                controller: 'qualificationEditController'
            })
            .when('/incidents', {
                templateUrl: 'views/incidents.html',
                controller: 'incidentsController'
            })
            .when('/incidentEdit', {
                templateUrl: 'views/incidentEdit.html',
                controller: 'incidentEditController'
            })
            .when('/incidentMap2', {
                templateUrl: 'views/incidentMap2.html',
                controller: 'incidentMap2Controller'
            })
            .when('/incidentTeam', {
                templateUrl: 'views/incidentTeam.html',
                controller: 'incidentTeamController'
            })
            .when('/incidentResources', {
                templateUrl: 'views/incidentResources.html',
                controller: 'incidentResourcesController'
            })
            .when('/incidentStatus', {
                templateUrl: 'views/incidentStatus.html',
                controller: 'incidentStatusController'
            })
            .when('/incidentOpPeriods', {
                templateUrl: 'views/incidentOpPeriods.html',
                controller: 'incidentOpPeriodsController'
            })
            .when('/incidentStatusEdit', {
                templateUrl: 'views/incidentStatusEdit.html',
                controller: 'incidentStatusEditController'
            })
            .when('/incidentAttach', {
                templateUrl: 'views/incidentAttach.html',
                controller: 'incidentAttachController'
            })
            .when('/documents', {
                templateUrl: 'views/documents.html',
                controller: 'documentsController'
            })
            .when('/confirm', {
                templateUrl: 'views/confirm.html',
                controller: 'confirmController'
            })
            .when('/config', {
                templateUrl: 'views/config.html',
                controller: 'configController'
            })
            .otherwise({
                redirectTo: '/'
            });
    }]);



    //****************************************************************************
    //WHEN APPLICATION FIRST RUNS
    //****************************************************************************
    app.run(function ($window, $rootScope, $location, authService, localStorageService, dbManagerService) {

        //window.shimIndexedDB.__useShim(); //only set this to force using WebSQL when debugging

        //****************************************************************************
        // sets server URL (from localStorage else hard coded)
        //****************************************************************************
        var url1 = localStorageService.get('serverURL');
        
        if (url1 == null) {
            console.log('Server URL getting initialized1');
            localStorageService.set('serverURL',
                {
//                    url: 'http://localhost:10418/'
                    url: 'http://12.238.224.120/emergencyhoundapi/'
                });
            url1 = localStorageService.get('serverURL');
        };

        if (url1.url == null) {
            console.log('Server URL getting initialized2');
            localStorageService.set('serverURL',
                {
//                url: 'http://localhost:10418/'
                url: 'http://12.238.224.120/emergencyhoundapi/'
            });
            url1 = localStorageService.get('serverURL');
        };

        $rootScope.serverBaseUrl = url1.url;
        console.log('Server URL is: ' + url1.url);


        //****************************************************************************
        // define the online status and also create events for going online or offline
        //****************************************************************************
        $rootScope.token = '';
        $rootScope.online = navigator.onLine;
        $rootScope.$apply();

        if (window.addEventListener) {
            window.addEventListener('online', function () {
                $rootScope.online = true;
                $rootScope.$apply();
            }, true);
            window.addEventListener('offline', function () {
                $rootScope.online = false;
                $rootScope.$apply();
            }, true);
        } else {
            document.body.ononline = function () {
                $rootScope.online = true;
                $rootScope.$apply();
            };
            document.body.onoffline = function () {
                $rootScope.online = false;
                $rootScope.$apply();
            };
        }



        //****************************************************************************
        // check authenticate state any time route changes
        //****************************************************************************
        authService.fillAuthData();


        //****************************************************************************
        //define event on changing route to check if user is authenticated
        //****************************************************************************
        $rootScope.$on('$routeChangeStart',
            function (event) {

                //***************authenticate every time route changes **********************
                console.log('authenticating');
                var authData = authService.authentication || { isAuth: false };

                // if route requires auth and user is not logged in
                var publicRoutes = ['/', '/login', '/config'];
                var isPublic = publicRoutes.indexOf($location.url()) >= 0;   //returns true if public

                if (!isPublic && !authData.isAuth) {
                    // redirect back to login
                    console.log('deny access ' + $location.url() + ' no auth');
                    event.preventDefault();
                    $rootScope.$evalAsync(function () {
                        $location.path('/login');
                    });
                }
                else {

                    //***************** identify if data needs to get submitted to server each time route changes
                    if ($rootScope.online == true) {
                        dbManagerService.getDataByIndex('people', 'synced', 0).then(function (res) {
                            dbManagerService.getDataByIndex('incidents', 'synced', 0).then(function (res2) {
                                dbManagerService.getDataByIndex('resources', 'synced', 0).then(function (res3) {
                                    $rootScope.$evalAsync(function () {
                                        $rootScope.needSync = (res.length > 0 || res2.length > 0 || res3.length > 0);
                                    });
                                });
                            });
                        });
                    }
                    else {
                        $rootScope.needSync = false;
                    }
                }
            });

    });
    

})();