angular.module('ehApp').controller('incidentResourceEditController',

    function ($scope, $location, $rootScope, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incidentresource = ehConstants.selectedIncidentResource;
        $scope.ddlStatusType = [{ statuS_TYPE_CD: "Health/Safety Brief", id: 1 }, { statuS_TYPE_CD: "Significant Event", id: 2 }, { statuS_TYPE_CD: "Situation Summary", id: 3 }];

        // datetime-picker formatting
        jQuery('.datetime-picker').datetimepicker({
            format: 'm/d/Y h:i A'
        });



        //******************* METHOD FOR CLOSING PAGE*************************
        $scope.close = function () {
            $location.path('/incidentResource');
        };


        //******************* METHOD FOR ASSIGNING RESOURCE*************************
        $scope.save = function () {
            //START VALIDATION
            if (!$scope.submitForm.$valid) {
                console.log('failed validation');
                return;
            }
            console.log('passed validation');
            //END VALIDATION

            $scope.incidentresource.synced = 0;
            $scope.incidentresource.modifY_DT = moment().format();

            //save locally
            dbManagerService.saveTable($scope.incidentresource, "incidentresources")
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incidentresource, "incidentresources", "api/incident/SetIncidentResource", $scope.incidentresource.incidenT_RESOURCE_IDX)
                    .then(function () {
                        $scope.saveState = 'Saved...and synced to server';
                    });
                }
                else {
                    $scope.saveState = 'Saved locally';
                }
            });


        };

        //******************* METHOD FOR DELETING RESOURCE*************************
        $scope.delete = function () {
            //if only stored locally, then just delete
            if ($scope.incidentresource.creatE_DT == null && $scope.incident.synced == false) {
                dbManagerService.deleteLocalRecord($scope.incidentresource.incidenT_RESOURCE_IDX, "incidentresources")
                    .then(function () {
                        //redirect to index page after delete
                        $location.path('/incidentResource');
                    });

                return;
            }

            //not only local, then need to mark for removal at server
            $scope.incidentresource.synced = false;
            $scope.incidentresource.acT_IND = false;
            $scope.incidentresource.modifY_DT = moment().format();

            //save incident locally
            dbManagerService.saveTable($scope.incidentresource, "incidentstatuses")
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incidentresource, "incidentresources", "api/incident/SetIncidentResource", $scope.incidentresource.incidenT_RESOURCE_IDX)
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