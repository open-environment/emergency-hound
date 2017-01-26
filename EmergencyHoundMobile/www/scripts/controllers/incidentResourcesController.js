angular.module('ehApp').controller('incidentResourcesController', 
    
    function ($scope, $http, $location, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;


    }

);