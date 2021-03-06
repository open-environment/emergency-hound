﻿angular.module('ehApp').controller('incidentResourceEditController',

    function ($scope, $location, $rootScope, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.incidentresource = ehConstants.selectedIncidentResource;
        $scope.incidentOrg = ehConstants.selectedIncident.orG_IDX;

        //get resource type dropdown
        dbManagerService.getDataByIndex('resources', 'orG_IDX', $scope.incidentOrg).then(function (resources) {
            dbManagerService.getRefTable('refResourceType').then(function (resTypes) {
                //map the returned resource list with the resource type
                $scope.ddlResources = _.map(resources, function (_temp) {
                    var _linkedRT = _.find(resTypes, function (q) { return _temp.resourcE_TYPE_IDX == q.resourcE_TYPE_IDX });
                    _temp.text = _linkedRT ? _linkedRT.resourcE_TYPE_NAME : '';
                    return _temp;
                });               
            });

        });


        // datetime-picker formatting
        jQuery('.datetime-picker').datetimepicker({
            format: 'm/d/Y h:i A'
        });



        //******************* METHOD FOR CLOSING PAGE*************************
        $scope.close = function () {
            $location.path('/incidentResources');
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

        //******************* METHOD FOR DELETING INCIDENT RESOURCE*************************
        $scope.delete = function () {
            //if only stored locally, then just delete
            if ($scope.incidentresource.creatE_DT == null && $scope.incidentresource.synced == false) {
                dbManagerService.deleteLocalRecord($scope.incidentresource.incidenT_RESOURCE_IDX, "incidentresources")
                    .then(function () {
                        //redirect to index page after delete
                        $location.path('/incidentResources');
                    });

                return;
            }

            //not only local, then need to mark for removal at server
            $scope.incidentresource.synced = false;
            $scope.incidentresource.acT_IND = false;
            $scope.incidentresource.modifY_DT = moment().format();

            //delete incident resource locally
            dbManagerService.saveTable($scope.incidentresource, "incidentresources")
            .then(function () {
                $scope.saveState = 'Deleted';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.incidentresource, "incidentresources", "api/incident/SetIncidentResource", $scope.incidentresource.incidenT_RESOURCE_IDX)
                    .then(function () {
                        //redirect to index page after delete
                        $location.path('/incidentResources');
                    });
                }
                else {
                    $scope.saveState = 'Deleted locally only';
                }
            });


        };



    }

);