angular.module('ehApp').controller('incidentTeamEditController',

    function ($scope, $location, $rootScope, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;
        $scope.incidentteam = ehConstants.selectedIncidentTeam;

        //get individual dropdown 
        dbManagerService.getRefTable('people').then(function (res) {
            $scope.ddlIndividual = _.sortBy(res, 'indV_FIRST_NAME');
        });

        //get team dropdown
        dbManagerService.getRefTable('resources').then(function (res) {
            dbManagerService.getRefTable('refResourceType').then(function (resource_ref) {

                //map the returned resource list with the resource type lookup to filter out teams
                $scope.ddlTeams = _.map(res, function (_temp) {
                    var _linkedRT = _.find(resource_ref, function (q) { return _temp.resourcE_TYPE_IDX == q.resourcE_TYPE_IDX });
                    _temp.resourcE_TYPE_NAME = _linkedRT ? _linkedRT.resourcE_TYPE_NAME : '';
                    return _temp;
                });

                $scope.ddlTeams = _.sortBy($scope.ddlTeams, 'resourcE_DESC');
                $scope.ddlTeams = _.where($scope.ddlTeams, { resourcE_KIND: "Team" })
            });
        });

        //get reports to dropdown
        dbManagerService.getDataByIndex('incidentteams', 'incidenT_IDX', $scope.incident.incidenT_IDX).then(function (reportsTo) {
            console.log(reportsTo);
            $scope.ddlReportsTo = _.sortBy(reportsTo, 'rolE_NAME');
        });


        // datetime-picker formatting
        jQuery('.datetime-picker').datetimepicker({
            format: 'm/d/Y h:i A'
        });



        //******************* METHOD FOR CLOSING PAGE*************************
        $scope.close = function () {
            $location.path('/incidentTeam');
        };


        //******************* METHOD FOR SAVING STATUS*************************
        $scope.save = function () {
            //START VALIDATION
            if (!$scope.submitForm.$valid) {
                console.log('failed validation');
                return;
            }
            console.log('passed validation');
            //END VALIDATION

            $scope.incidentteam.synced = 0;
            $scope.incidentteam.modifY_DT = moment().format();

            //save locally
            dbManagerService.saveTable($scope.incidentteam, "incidentteams")
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incidentteam, "incidentteams", "api/incident/SetIncidentTeam", $scope.incidentteam.incidenT_TEAM_DTL_IDX)
                    .then(function () {
                        $scope.saveState = 'Saved...and synced to server';
                    });
                }
                else {
                    $scope.saveState = 'Saved locally';
                }
            });


        };

        //******************* METHOD FOR DELETING STATUS*************************
        $scope.delete = function () {
            //if only stored locally, then just delete
            if ($scope.incidentteam.creatE_DT == null && $scope.incident.synced == false) {
                dbManagerService.deleteLocalRecord($scope.incidentteam.incidenT_TEAM_DTL_IDX, "incidentteams")
                    .then(function () {
                        //redirect to index page after delete
                        $location.path('/incidentTeam');
                    });

                return;
            }

            //not only local, then need to mark for removal at server
            $scope.incidentteam.synced = false;
            $scope.incidentteam.acT_IND = false;
            $scope.incidentteam.modifY_DT = moment().format();

            //save incident locally
            dbManagerService.saveTable($scope.incidentteam, "incidentteams")
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incidentteam, "incidentteams", "api/incident/SetIncidentTeam", $scope.incidentteam.incidenT_TEAM_DTL_IDX)
                    .then(function () {
                        $scope.saveState = 'Saved...and synced to server';
                    });
                }
                else {
                    $scope.saveState = 'Saved locally only';
                }
            });


        };


    }

);