angular.module('ehApp').controller('incidentTeamController', 
    
    function ($scope, $http, $location, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;
        $scope.teams = [];

        dbManagerService.getDataByIndex('incidentteams', 'incidenT_IDX', $scope.incident.incidenT_IDX).then(function (teams) {
            dbManagerService.getRefTable('people').then(function (people) {
                dbManagerService.getRefTable('resources').then(function (resource_ref) {

                    //map the returned team list with the individuals lookup
                    $scope.teams = _.map(teams, function (_temp) {
                        var _linkedRT = _.find(people, function (q) { return _temp.individuaL_IDX == q.individuaL_IDX });
                        _temp.indv_name = _linkedRT ? _linkedRT.indV_FIRST_NAME + ' ' + _linkedRT.indV_LAST_NAME : '';
                        return _temp;
                    });

                    //map the returned team list with the individuals lookup
                    $scope.teams = _.map($scope.teams, function (_temp) {
                        var _linkedRT = _.find(resource_ref, function (q) { return _temp.resourcE_IDX == q.resourcE_IDX });
                        _temp.resourcE_DESC = _linkedRT ? _linkedRT.resourcE_DESC : '';
                        return _temp;
                    });

                    //map the returned team list to reports to
                    var tempReportsTo = $scope.teams;
                    $scope.teams = _.map($scope.teams, function (_temp) {
                        var _linkedRT = _.find(tempReportsTo, function (q) { return _temp.reportS_TO_TEAM_DTL_IDX == q.incidenT_TEAM_DTL_IDX });
                        _temp.reportsToRole = _linkedRT ? _linkedRT.rolE_NAME : '';
                        return _temp;
                    });

                    //finally sort by sequence and reports to
                    $scope.teams = _.sortBy((_.sortBy($scope.teams, 'reportS_TO_TEAM_DTL_IDX')).reverse(), 'seQ_NO');

                });
            });
        });


        //******************************************
        //method for clicking Add new button
        //******************************************
        $scope.addIncidentTeam = function () {
            ehConstants.selectedIncidentTeam = dbManagerService.newIncidentTeam($scope.incident.incidenT_IDX);
            $location.path('/incidentTeamEdit');
        };

        //******************************************
        //method for clicking Edit button
        //******************************************
        $scope.editIncidentTeam = function (id) {
            ehConstants.selectedIncidentTeam = _.findWhere($scope.teams, { incidenT_TEAM_DTL_IDX: id });
            $location.path('/incidentTeamEdit');
        };


    }

);