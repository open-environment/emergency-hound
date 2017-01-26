angular.module('ehApp').controller('resourceVerifyController', 
    
    function ($scope, $location, $rootScope, ehConstants, cfpLoadingBar, dbManagerService) {

        //******************* VIEW INITIALIZATION  *************************
        $scope.resource = ehConstants.selectedResource;

        dbManagerService.getRefTable('resourceverify').then(function (res) {
            $scope.verifies = 
                _.where(res, { resourcE_IDX: $scope.resource.resourcE_IDX });
        });


        //******************* METHOD FOR CLOSE BUTTON*************************
        $scope.close = function () {
            $location.path('/resourceEdit2');
        };


    }
);