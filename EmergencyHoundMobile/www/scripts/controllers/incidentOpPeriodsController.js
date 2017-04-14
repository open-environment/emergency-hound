angular.module('ehApp').controller('incidentOpPeriodsController',

    function ($scope, $http, $location, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;
        $scope.periods = [];

        dbManagerService.getDataByIndex('incidentopperiods', 'incidenT_IDX', $scope.incident.incidenT_IDX).then(function (periods) {
            $scope.periods = periods;
        });


        //******************************************
        //method for clicking Add new button
        //******************************************
        $scope.addOpPeriod = function () {
            ehConstants.selectedIncidentOpPeriod = dbManagerService.newIncidentOpPeriod($scope.incident.incidenT_IDX);
            console.log('adding');
            $location.path('/incidentOpPeriodEdit');
        };

        //******************************************
        //method for clicking Edit button
        //******************************************
        $scope.editOpPeriod = function (id) {
            ehConstants.selectedIncidentOpPeriod = _.findWhere($scope.periods, { incidenT_OP_PERIOD_IDX: id });
            console.log('editing');
            $location.path('/incidentOpPeriodEdit');

        };


    }

);