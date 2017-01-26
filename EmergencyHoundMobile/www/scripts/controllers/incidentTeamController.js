angular.module('ehApp').controller('incidentTeamController', 
    
    function ($scope, $http, $location, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;


    }

);