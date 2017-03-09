angular.module('ehApp').controller('incidentResourcesController', 
    
    function ($scope, $http, $location, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;
        $scope.resources = [];

        dbManagerService.getDataByIndex('incidentresources', 'incidenT_IDX', $scope.incident.incidenT_IDX).then(function (resources) {
            $scope.resources = resources;
        });


        //******************************************
        //method for clicking Add new button
        //******************************************
        $scope.addIncidentResource = function () {
            ehConstants.selectedIncidentResource = dbManagerService.newIncidentResource($scope.incident.incidenT_IDX);
            $location.path('/incidentResourceEdit');
        };

        //******************************************
        //method for clicking Edit button
        //******************************************
        $scope.editIncidentResource = function (id) {
            ehConstants.selectedIncidentResource = _.findWhere($scope.resources, { incidenT_RESOURCE_IDX: id });
            $location.path('/incidentResourceEdit');
        };



    }

);