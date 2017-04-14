angular.module('ehApp').controller('incidentStatusEditController',

    function ($scope, $location, $rootScope, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incident = ehConstants.selectedIncident;
        $scope.incidentstatus = ehConstants.selectedIncidentStatus;
        $scope.ddlStatusType = [{ statuS_TYPE_CD: "Health/Safety Brief", id: 1 }, { statuS_TYPE_CD: "Significant Event", id: 2 }, { statuS_TYPE_CD: "Situation Summary", id: 3 }];

        // datetime-picker formatting
        jQuery('.datetime-picker').datetimepicker({
            format: 'm/d/Y h:i A'
        });



        //******************* METHOD FOR CLOSING PAGE*************************
        $scope.close = function () {
            $location.path('/incidentStatus');
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

            $scope.incidentstatus.synced = 0;
            $scope.incidentstatus.modifY_DT = moment().format();

            //save locally
            dbManagerService.saveTable($scope.incidentstatus, "incidentstatuses")
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incidentstatus, "incidentstatuses", "api/incident/SetIncidentStatus", $scope.incidentstatus.inC_STATUS_IDX)
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
            if ($scope.incidentstatus.creatE_DT == null && $scope.incident.synced == false) {
                dbManagerService.deleteLocalRecord($scope.incidentstatus.inC_STATUS_IDX, "incidentstatuses")
                    .then(function () {
                        //redirect to index page after delete
                        $location.path('/incidentStatus');
                    });

                return;
            }

            //not only local, then need to mark for removal at server
            $scope.incidentstatus.synced = false;
            $scope.incidentstatus.acT_IND = false;
            $scope.incidentstatus.modifY_DT = moment().format();

            //save incident locally
            dbManagerService.saveTable($scope.incidentstatus, "incidentstatuses")
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incidentstatus, "incidentstatuses", "api/incident/SetIncidentStatus", $scope.incidentstatus.inC_STATUS_IDX)
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