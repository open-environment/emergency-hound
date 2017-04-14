angular.module('ehApp').controller('incidentResourcesController', 
    
    function ($scope, $http, $location, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;
        $scope.resources = [];

        dbManagerService.getDataByIndex('incidentresources', 'incidenT_IDX', $scope.incident.incidenT_IDX).then(function (incidentresources) {
            dbManagerService.getRefTable('resources').then(function (resource_ref) {

                //map the returned resource list with the resource type
                $scope.resources = _.map(incidentresources, function (_temp) {
                    var _linkedRT = _.find(resource_ref, function (q) { return _temp.resourcE_IDX == q.resourcE_IDX });
                    _temp.resourcE_DESC = _linkedRT ? _linkedRT.resourcE_DESC : '';
                    return _temp;
                });
            });
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