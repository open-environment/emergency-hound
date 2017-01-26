angular.module('ehApp').controller('incidentStatusController',

    function ($scope, $location, $rootScope, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;
        $scope.statuses = [];

        dbManagerService.getDataByIndex('incidentstatuses', 'incidenT_IDX', $scope.incident.incidenT_IDX).then(function (statuses) {
            $scope.statuses = statuses;

        });


        //******************************************
        //method for clicking Add new button
        //******************************************
        $scope.addIncidentStatus = function () {
            ehConstants.selectedIncidentStatus = dbManagerService.newIncidentStatus($scope.incident.incidenT_IDX);
            $location.path('/incidentStatusEdit');
        };

        //******************************************
        //method for clicking Edit button
        //******************************************
        $scope.editIncidentStatus = function (id) {
            ehConstants.selectedIncidentStatus = _.findWhere($scope.statuses, { inC_STATUS_IDX: id });
            $location.path('/incidentStatusEdit');
        };



    }
);