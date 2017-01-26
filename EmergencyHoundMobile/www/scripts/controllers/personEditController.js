angular.module('ehApp').controller('personEditController', 
    
    function ($scope, $location, $rootScope, cfpLoadingBar, ehConstants, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.person = ehConstants.selectedPerson;
        $scope.qualifications = [];

        //get organization 
        dbManagerService.getRefTable('organizations').then(function (res) {
            $scope.ddlOrganizations = res;
        });

        //get qualifications
        dbManagerService.getRefTable('qualifications').then(function (res) {
            $scope.qualifications = 
                    _.where(res, { individuaL_IDX: $scope.person.individuaL_IDX });
        });

        //get qual types
        dbManagerService.getRefTable('refQualType').then(function (res) {
            $scope.qualtypes = res;
        });



        //******************* METHOD FOR SAVING PERSON*************************
        $scope.save = function () {
            //START VALIDATION
            if (!$scope.submitForm.$valid) {
                console.log('falied validation');
                return;
            }
            console.log('passed validation');
            //END VALIDATION

            $scope.person.synced = 0;
            $scope.person.modifY_DT = moment().format();

            //save person locally
            dbManagerService.saveTable($scope.person, "people")
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.person, "people", "api/resource/SetIndividual", $scope.person.individuaL_IDX)
                    .then(function () {
                        $scope.saveState = 'Saved...and synced to server';
                    });
                }
                else {
                    $scope.saveState = 'Saved locally';
                }
            });
        };


        //******************* METHOD FOR DELETING PERSON*************************
        $scope.delete = function () {
            //if only stored locally, then just delete
            if ($scope.person.creatE_DT == null && $scope.person.synced == false) {
                dbManagerService.deleteLocalRecord($scope.person.individuaL_IDX, "people")
                    .then(function () {
                        //redirect to index page after delete
                        $location.path('/people');
                    });

                return;
            }

            //not only local, then need to mark for removal at server
            $scope.person.synced = false;
            $scope.person.acT_IND = false;
            $scope.person.modifY_DT = moment().format();

            //save incident locally
            dbManagerService.saveTable($scope.person, "people")
            .then(function () {
                $scope.saveState = 'Saved';

                //if online, attempt to save remotely
                if ($rootScope.online == true) {
                    dbManagerService.syncRowToServer($scope.person, "people", "api/resource/SetIndividual", $scope.person.individuaL_IDX)
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
            $location.path('/people');
        };


        //********************* METHOD FOR EDIT QUALIFICATION *******************
        $scope.editQual = function (id) {
            ehConstants.selectedQual =
                _.findWhere($scope.qualifications, { qualificatioN_IDX: id });

            $location.path('/qualificationEdit');
        };


        //********************* METHOD FOR ADD QUALIFICATION *******************
        $scope.addQual = function () {
            ehConstants.selectedQual = dbManagerService.newQualification($scope.person.orG_IDX, $scope.person.individuaL_IDX);
            $location.path('/qualificationEdit');
        };
    }
);