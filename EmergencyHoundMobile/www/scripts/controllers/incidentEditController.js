angular.module('ehApp').controller('incidentEditController', 
    
    function ($scope, $location, $rootScope, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;

        //get ref share type
        dbManagerService.getRefTable('refShareType').then(function (res) {
            $scope.ddlShareType = res;
        });

        //get organization 
        dbManagerService.getRefTable('organizations').then(function (res) {
            $scope.ddlOrganizations = res;
        });

        //get priority
        dbManagerService.getRefTable('refIncidentPriority').then(function (res) {
            $scope.ddlPriority = res;
        });

        // datetime-picker formatting
        jQuery('.datetime-picker').datetimepicker({
            format: 'm/d/Y h:i:s A'
        });



        //******************* METHOD FOR SAVING INCIDENT*************************
        $scope.save = function () {
            //START VALIDATION
            if (!$scope.submitForm.$valid) {
                console.log('failed validation');
                return;
            }
            //END VALIDATION

            $scope.incident.synced = false;
            $scope.incident.modifY_DT = moment().format();

            //save incident locally
            dbManagerService.saveIncident($scope.incident)
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incident, "incidents", "api/incident/SetIncidents", $scope.incident.incidenT_IDX)
                    .then(function () {
                        $scope.saveState = 'Saved...and synced to server';
                    });
                }
                else {
                    $scope.saveState = 'Saved locally';
                }
            });            
        };


        //******************* METHOD FOR DELETING INCIDENT*************************
        $scope.delete = function ()
        {
            //if only stored locally, then just delete
            if ($scope.incident.creatE_DT == null && $scope.incident.synced == false) {
                dbManagerService.deleteLocalRecord($scope.incident.incidenT_IDX, "incidents")
                    .then(function () {
                    //redirect to index page after delete
                    $location.path('/incidents');
                });

                return;
            }

            //not only local, then need to mark for removal at server
            $scope.incident.synced = false;
            $scope.incident.acT_IND = false;
            $scope.incident.modifY_DT = moment().format();

            //save incident locally
            dbManagerService.saveIncident($scope.incident)
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incident, "incidents", "api/incident/SetIncidents", $scope.incident.incidenT_IDX)
                    .then(function () {
                        $scope.saveState = 'Saved...and synced to server';
                    });
                }
                else {
                    $scope.saveState = 'Saved locally only';
                }
            });            


        };



        //******************* METHOD FOR CLOSE BUTTON*************************
        $scope.close = function () {
            $location.path('/incidents');
        };

    }

);