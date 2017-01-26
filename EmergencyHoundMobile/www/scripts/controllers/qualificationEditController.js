angular.module('ehApp').controller('qualificationEditController',

    function ($scope, $rootScope, $location, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION *****************************
        $scope.qualification = ehConstants.selectedQual;

        //get qualification type dropdown
        dbManagerService.getRefTable('refQualType').then(function (res) {
            $scope.ddlQualType = res;
        });

        // datetime-picker formatting
        jQuery('.datetime-picker').datetimepicker({
            format: 'm/d/Y'
        });


        //method for close button click
        $scope.close = function () {
            $location.path('/personEdit');
        };


        //method for save button click
        $scope.save = function () {
            //START VALIDATION
            if (!$scope.submitForm.$valid) {
                console.log('failed validation');
                return;
            }
            console.log('passed validation');
            //END VALIDATION

            $scope.qualification.synced = 0;
            $scope.qualification.modifY_DT = moment().format();

            //save person locally
            dbManagerService.saveTable($scope.qualification, "qualifications")
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.qualification, "qualifications", "api/resource/SetQualification", $scope.qualification.qualificatioN_IDX)
                    .then(function () {
                        $scope.saveState = 'Saved...and synced to server';
                    });
                }
                else {
                    $scope.saveState = 'Saved locally';
                }
            });


        };

    }
);