angular.module('ehApp').controller('incidentOpPeriodEditController',

    function ($scope, $location, $rootScope, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incidentopperiod = ehConstants.selectedIncidentOpPeriod;
        $scope.incidentOrg = ehConstants.selectedIncident.orG_IDX;

        // datetime-picker formatting
        jQuery('.datetime-picker').datetimepicker({
            format: 'm/d/Y h:i A'
        });



        //******************* METHOD FOR CLOSING PAGE*************************
        $scope.close = function () {
            $location.path('/incidentOpPeriods');
        };


        //******************* METHOD FOR ASSIGNING OP PERIOD*************************
        $scope.save = function () {
            //START VALIDATION
            if (!$scope.submitForm.$valid) {
                console.log('failed validation');
                return;
            }
            console.log('passed validation');
            //END VALIDATION

            $scope.incidentopperiod.synced = 0;
            $scope.incidentopperiod.modifY_DT = moment().format();

            //save locally
            dbManagerService.saveTable($scope.incidentopperiod, "incidentopperiods")
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incidentopperiod, "incidentopperiods", "api/incident/SetIncidentOpPeriod", $scope.incidentopperiod.incidenT_OP_PERIOD_IDX)
                    .then(function () {
                        $scope.saveState = 'Saved...and synced to server';
                    });
                }
                else {
                    $scope.saveState = 'Saved locally';
                }
            });


        };

        //******************* METHOD FOR DELETING INCIDENT RESOURCE*************************
        $scope.delete = function () {
            //if only stored locally, then just delete
            if ($scope.incidentopperiod.creatE_DT == null && $scope.incidentopperiod.synced == false) {
                dbManagerService.deleteLocalRecord($scope.incidentopperiod.incidenT_OP_PERIOD_IDX, "incidentopperiods")
                    .then(function () {
                        //redirect to index page after delete
                        $location.path('/incidentOpPeriods');
                    });

                return;
            }

            //not only local, then need to mark for removal at server

            console.log('f' + $scope.incidentopperiod.incidenT_OP_PERIOD_IDX);

            $scope.incidentopperiod.synced = false;
            $scope.incidentopperiod.acT_IND = false;
            $scope.incidentopperiod.modifY_DT = moment().format();

            //delete incident resource locally
            dbManagerService.saveTable($scope.incidentopperiod, "incidentopperiods")
            .then(function () {
                $scope.saveState = 'Deleted';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incidentopperiod, "incidentopperiods", "api/incident/SetIncidentOpPeriod", $scope.incidentopperiod.incidenT_OP_PERIOD_IDX)
                    .then(function () {
                        //redirect to index page after delete
                        $location.path('/incidentOpPeriods');
                    });
                }
                else {
                    $scope.saveState = 'Deleted locally only';
                }
            });
        };


    }

);